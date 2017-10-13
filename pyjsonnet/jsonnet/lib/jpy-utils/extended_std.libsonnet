{
  local utils = self,
# Generate a sequence array from 1 to i
   seq(i):: (
      [x for x in std.range(1, i)]
   ),

   compact(array):: (
     [x for x in array if x != null]
   ),

  objectFieldsHidden(obj):: (
     std.setDiff(std.objectFieldsAll(obj), std.objectFields(obj))
  ),

  objectFlatten(obj):: (
    // Merge 1 level dict depth into toplevel
    local visible = {[k]: obj[j][k],
                    for j in std.objectFieldsAll(obj)
                    for k in std.objectFieldsAll(obj[j])};

    visible
  ),

   set(array)::
        { [key]: key for key in array },

  arrayHas(array, value):: (
     value in utils.set(array)
  ),

  path: {
    basename(path):: (local x = std.split(path, "/"); x[std.length(x) -1]),
   },

   objectValues(obj):: (
     local fields =  std.objectFields(obj);
      [obj[key] for key in fields]
   ),

   objectMap(func, obj):: (
    local fields = std.objectFields(obj);
    {[key]: func(obj[key]) for key in fields}
    ),

   capitalize(str):: (
     std.char(std.codepoint(str[0]) - 32) + str[1:]
   ),


   __tests__:: {
       arrayHas: (assert utils.arrayHas(["a", "foo"], "foo") == true;
                 assert utils.arrayHas([], "af") == false;
                 assert utils.arrayHas(["a", "foo"], "bad") == false;
       true),

        capitalize: (assert utils.capitalize("test") == 'Test'; true),
        basename: (assert utils.path.basename("/foo/bar/toto") == "toto";
                   assert utils.path.basename("foo") == "foo";
                   assert utils.path.basename("foo/") == "";
                   assert utils.path.basename("/foo") == "foo";
                   assert utils.path.basename("") == "";
                   true),
        }

}
