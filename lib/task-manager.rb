
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
      data[:id] = @projects_counter
      @projects[@projects_counter] = data
      @projects_counter += 1
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
