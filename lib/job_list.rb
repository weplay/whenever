module Whenever
  class JobList
  
    def initialize(options)
      @jobs = Hash.new
      @env  = Hash.new
      
      config = case options
        when String then options
        when Hash
          if options[:string]
            options[:string]
          elsif options[:file]
            File.read(options[:file])
          end
      end

      eval(config)
    end
    
    def set(variable, value)
      instance_variable_set("@#{variable}".to_sym, value)
      self.class.send(:attr_reader, variable.to_sym)
    end
    
    def env(variable, value)
      @env[variable.to_s] = value
    end
  
    def every(frequency, options = {})
      @current_time_scope = frequency
      @options = options
      yield
    end

    def daily(options = {})
      every(1.day, options) do
        yield
      end
    end

    def hourly(options = {})
      every(1.hour, options) do
        yield
      end
    end
    
    def raw(cron_syntax)
      @current_time_scope = Whenever::Timing::RawCron.new(cron_syntax)
      yield
    end
    
    def command(task, options = {})
      options[:cron_log] ||= @cron_log unless options[:cron_log] === false
      options[:class]    ||= Whenever::Job::Default
      @jobs[@current_time_scope] ||= []
      @jobs[@current_time_scope] << options[:class].new(@options.merge(:task => task).merge(options))
    end
      
    def generate_cron_output
      [environment_variables, cron_jobs].compact.join
    end
    
    def method_missing(method_name, *args)
      candidate_job_class_name = camelize(method_name)
      if Whenever::Job.const_defined?(candidate_job_class_name)
        task = args[0]
        options = args[1] || {}
        options.reverse_merge!(:environment => @environment, :path => @path)
        options[:class] = Whenever::Job.const_get candidate_job_class_name
        command(task, options)
      else
        super
      end
    end
    
  private
  
    def environment_variables
      return if @env.empty?
      
      output = []
      @env.each do |key, val|
        output << "#{key}=#{val}\n"
      end
      output << "\n"
      
      output.join
    end
    
    def cron_jobs
      return if @jobs.empty?
      
      output = []
      @jobs.each do |time, jobs|
        jobs.each do |job|
          cron = Whenever::Output::Cron.output(time, job)
          cron << " >> #{job.cron_log} 2>&1" if job.cron_log 
          cron << "\n"
          output << cron
        end
      end
      
      output.join
    end
    
    def camelize(lower_case_and_underscored_word)
      lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
    end
    
    
  end
end