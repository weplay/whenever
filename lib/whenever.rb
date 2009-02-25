require 'activesupport'
require 'chronic'

module Whenever
  def self.path
    return RAILS_ROOT if defined? RAILS_ROOT
    ::RAILS_ROOT
  end
  
  def self.cron(options)
    JobList.new(options).generate_cron_output
  end
  
  autoload :VERSION,  'whenever/version'
  autoload :JobList,  'whenever/job_list'
  autoload :JobTypes, 'whenever/job_types'
  autoload :Output,   'whenever/output'
end
