module Whenever
  module Job
    class SphinxIndexer < Whenever::Job::Default
      
      def output
        path_required
        out = "cd #{@path} && RAILS_ENV=#{@environment} "
        out << lockrun(@lockrun) if @lockrun 
        out << "indexer --config #{@task} --rotate --all --quiet"
        out
      end
      
    end
  end
end
