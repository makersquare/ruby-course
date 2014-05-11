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

    #  Project Methods

    def create_project(data)
      @projects_counter += 1
      data[:id] = @projects_counter
      data[:completed] = false
      @projects[@projects_counter] = data
    end

    def get_project(id)
      build_project(@projects[id])
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
      TM::Project.new(data[:name], data[:id], data[:completed])
    end

    # Task Methods

    def create_task(data)
      @task_counter += 1
      data[:id] = @task_counter
      data[:completed] = false
      @task[@task_counter] = data
    end

    def get_task(id)
      build_task(@task[id])
    end

    def update_task(id, data)
      task = @task[id]
      data.each do |key, value|
        task[key] = value
      end
    end

    def destroy_task(id)
      @task.delete(id)
    end

    def build_task(data)
      TM::Task.new(data[:id], data[:pid], data[:completed], data[:description], data[:priority])
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
