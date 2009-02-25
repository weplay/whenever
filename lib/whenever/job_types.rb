module Whenever
  module JobTypes
    autoload :Default,  'whenever/job_types/default'
    autoload :RakeTask, 'whenever/job_types/rake_task'
    autoload :Runner,   'whenever/job_types/runner'
  end
end
