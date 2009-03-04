module Whenever
  module Job
    class Rake < Whenever::Job::Default
      
      def output
        path_required
        "cd #{@path} && RAILS_ENV=#{@environment} /usr/bin/env rake #{'--silent ' unless @silent == false}#{task}"
      end
      
    end
  end
end
