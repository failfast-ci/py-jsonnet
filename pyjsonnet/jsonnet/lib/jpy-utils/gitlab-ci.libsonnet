{

  // Merge array of jobs with a base job definition
  mergeJob(base_job, jobs, stage=null):: {
  [job_name]: base_job + jobs[job_name] +
         if stage != null then {stage: stage} else {}
  for job_name in std.objectFields(jobs)
},


    // Restrict job to run on master and Tags
    // to be used with `+`: {..job...} + onlyMaster
    onlyMaster: {
        only: ['master', 'tags'],
    },

    // Restrict jobs to run on branches only
    // to be used with `+`: {..job...} + onlyBranches
    onlyBranch: {
        only: ['branches'],
        except: ['master', 'tags'],
    },


}
