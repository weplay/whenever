require 'activesupport'
require 'chronic'

module Whenever
  def self.path
    if defined?(RAILS_ROOT)
      RAILS_ROOT 
    elsif defined?(::RAILS_ROOT)
      ::RAILS_ROOT
    end
  end
  
  def self.cron(options)
    Whenever::JobList.new(options).generate_cron_output
  end
  
  autoload :VERSION,  'whenever/version'
  autoload :JobList,  'whenever/job_list'
  autoload :JobTypes, 'whenever/job_types'
  autoload :Output,   'whenever/output'
end
