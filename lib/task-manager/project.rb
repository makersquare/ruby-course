
require 'pry-debugger'

class TM::Project
    attr_accessor :name, :id_counter, :pid, :projects, :completed_tasks, :tasks

    @@id_counter = 0
    @@projects = []
    def initialize(name)
      @name = name
      @@id_counter += 1
      @pid = @@id_counter
      @@projects << self
    end

    def self.reset_class_variables
      @@id_counter = 0
      @@projects = []
    end

    def self.list_projects
      @@projects
    end

    def self.project_name(projectid)
      p = @@projects.select {|project| project.pid == projectid}
      p = p[0]
      p.name
    end

end
