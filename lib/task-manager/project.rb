
class TM::Project

    attr_accessor :name, :pid

    @pid = 0
    def initialize(name)
      @name = name
      @pid += 1
    end

end
