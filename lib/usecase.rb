require 'ostruct'

module Timeline
  class UseCase   # UseCase class
    # Convenience method that lets us call `.run` directly on the class
    def self.run(inputs=nil)         # your specific use case, will inherent from this class
      self.new.run(inputs)       # this method will run, your run method in your specific usecase scenario
    end

    def failure(error_sym, data={}) # this will merge your input, so you can merge and call dot notatiion
      UseCaseFailure.new(data.merge :error => error_sym) # makes a new UseCaseFailure
    end

    def success(data={}) # this will make a useCaseSuccess
      UseCaseSuccess.new(data)
    end
  end

  class UseCaseFailure < OpenStruct
    def success?
      false
    end
    def error?
      true
    end
  end

  class UseCaseSuccess < OpenStruct
    def success?
      true
    end
    def error?
      false
    end
  end
end
