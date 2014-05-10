require 'pry'

# Create our module. This is so other files can start using it immediately
module TM
  class Database

    attr_reader :projects, :task, :projects_counter, :task_counter

    def initialize
      @projects = {}
      @task = {}
      @projects_counter = 0
      @task_counter = 0
    end

    def create_project(data)
      @projects_counter += 1
      data[:id] = @projects_counter
      data[:completed] = false
      @projects[@projects_counter] = data
      build_project(@projects[@projects_counter])
    end

    def get_project(id)
      project = @projects[id]
      build_project(project)
    end

    def update_project(id, data)
      project = @projects[id]
      data.each do |key, value|
        project[key] = value
      end
    end

    def destroy_project(id)
      @projects.delete(id)
    end

    def build_project(data)
      TM::Project.new(data[:name], data[:id], data[:complted])
    end

  end

  def self.db
    @__db_instance ||= Database.new
  end
end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/projectsmanager.rb'
require_relative 'task-manager/terminal.rb'

# t = TM::TerminalClient.new
# t.run_program
