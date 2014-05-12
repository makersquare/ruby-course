
require 'pry-debugger'

class TM::Project
    attr_accessor :name, :pid, :complete

    def initialize(name, pid)
      @name = name
      @complete = false
      @pid = pid
    end

end
