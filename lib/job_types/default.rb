module Whenever
  module Job
    class Default
      
      attr_accessor :task, :at, :cron_log
    
      def initialize(options = {})
        @environment = options.delete(:environment) || ENV['RAILS_ENV'] || :production
        @path        = options.delete(:path) || Whenever.path
        options.keys.each do |option_name|
          instance_variable_set("@#{option_name}", options[option_name])
        end
      end
    
      def output
        task
      end
      
      def lockrun(lockrun_name)
        "/usr/bin/lockrun --lockfile=/var/run/lockrun/#{lockrun_name}.lockrun -- "
      end
      
    protected
      
      def path_required
        raise ArgumentError, "No path available; set :path, '/your/path' in your schedule file" if @path.blank?
      end
      
    end
  end
end