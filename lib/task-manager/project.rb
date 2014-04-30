
require 'pry-debugger'

class TM::Project
    attr_accessor :name, :id_counter, :pid, :projects, :completed_tasks, :incomplete_tasks

    @@id_counter = 0
    @@projects = []
    def initialize(name)
      @name = name
      @@id_counter += 1
      @pid = @@id_counter
      @completed_tasks = []
      @incomplete_tasks = []
    end

    def self.reset_class_variables
      @@id_counter = 0
    end

    def mark_complete(pid, tid)
    end

    def completed_tasks(pid)
    end

    def incomplete_tasks(pid)
    end

    def list_projects
    end
end
