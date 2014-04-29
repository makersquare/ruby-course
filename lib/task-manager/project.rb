
require 'pry-debugger'

class TM::Project
    attr_accessor :name, :id_counter, :pid, :projects

    @@id_counter = 0
    @@projects = []
    def initialize(name)
      @name = name
      @@id_counter += 1
      @pid = @@id_counter
      @@projects << {:name => @pid}
    end

end
