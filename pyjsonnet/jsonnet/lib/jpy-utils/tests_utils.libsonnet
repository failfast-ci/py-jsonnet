        {
        runTests(libraries):: (
  local result = {} +
   {[name]: if "__tests__" in libraries[name]
   then
    libraries[name]["__tests__"]
   else
     'No tests found'
  for name in std.objectFields(libraries) if name != "__tests__"};
  result
  ),

  }
