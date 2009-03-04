module Whenever
  module Timing
    class RawCron
      def initialize(cron_syntax)
        @cron_syntax = cron_syntax
      end
  
      def to_s
        @cron_syntax
      end
    end
  end
end