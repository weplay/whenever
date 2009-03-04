module Whenever
  module Job
    class Curl < Whenever::Job::Default
      
      def output
        out = ''
        out << lockrun(@lockrun) if @lockrun 
        out << "curl --silent --show-error #{@task} -o /dev/null"
        out
      end
      
    end
  end
end
