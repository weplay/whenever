unless defined?(Whenever)
  $:.unshift(File.dirname(__FILE__))
   
  # Hoping to load Rails' Rakefile
  begin
    load 'Rakefile'
  rescue LoadError => e
    nil
  end
end

# Dependencies
require 'active_support'
require 'chronic'

# Whenever files
%w{ base
    version
    job_list
    job_types/default
    job_types/curl
    job_types/enqueue_job
    job_types/sphinx_indexer
    job_types/rake
    job_types/runner
    outputs/cron
    timing/raw_cron }.each do |file|
  require	File.expand_path(File.dirname(__FILE__) + "/#{file}")
end