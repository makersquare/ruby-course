
require 'pry-debugger'

class TM::Employee
    attr_accessor :name, :eid

    def initialize(name, eid)
      @name = name
      @eid = eid
    end

end
