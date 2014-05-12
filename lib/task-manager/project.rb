
require 'pry-debugger'

class TM::Project
    attr_accessor :name, :pid

    def initialize(name, pid)
      @name = name
      @pid = pid
    end

end
