module PM
  class Project
    attr_reader :id, :description, :priority

    def initialize(description, priority)
      @description, @priority = description, priority
    end
  end
end
