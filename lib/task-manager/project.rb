
class TM::Project

    attr_accessor :name, :pid

    def initialize(name)
      @name = name
      @pid = Time.now.to_i
    end

end
