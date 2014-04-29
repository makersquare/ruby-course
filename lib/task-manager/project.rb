
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
      @completed_tasks = []
    end

    def history(pid)
      @completed_tasks
    end

end
