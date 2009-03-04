module Whenever
  module Job
    class EnqueueJob < Whenever::Job::Default
      
      def output
        path_required
        "cd #{@path} && script/enqueue_job -q -e #{@environment} '#{task}'"
      end
      
    end
  end
end
