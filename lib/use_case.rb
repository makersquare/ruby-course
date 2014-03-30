# This is needed for OpenStruct. Google "ruby openstruct" for more info
require 'ostruct'

module TM

  class UseCase
    # Convenience method that lets us call `.run` directly on the class
    def self.run(inputs=nil)
      if inputs == nil
        self.new.run
      else
        self.new.run(inputs)
      end
    end

    def failure(error_sym, data={})
      UseCaseFailure.new(data.merge :error => error_sym)
    end

    def success(data={})
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
