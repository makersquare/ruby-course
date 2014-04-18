require 'ostruct'

module Timeline

  class UseCase
    def self.run(inputs)
      self.new.run(inputs)
    end

    def failure(error_sym)
      UseCaseFailure.new(:error => error_sym)
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
