# lib/use_case.rb

# This is needed for OpenStruct. Google "ruby openstruct" for more info
require 'ostruct'

module Timeline

  class UseCase
    # Convenience method that lets us call `.run` directly on the class
    def self.run(inputs)
      self.new.run(inputs)  #this method will run for your specific usecase scenario
    end

    def failure(error_sym, data={})
      UseCaseFailure.new(data.merge :error => error_sym)
    end

    def success(data={})
      UseCaseSuccess.new(data)
    end
  end

  class UseCaseFailure < OpenStruct
    def success? #set to false, because we failed
      false
    end
    def error?
      true
    end
  end

  class UseCaseSuccess < OpenStruct
    def success? #set to true because we succeeded
      true
    end
    def error?
      false
    end
  end
end
