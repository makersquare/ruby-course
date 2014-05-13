require 'pry'

# Create our module. This is so other files can start using it immediately
module TM
  class Database

    attr_reader :projects, :task, :employees, :project_membership, :employee_counter, :projects_counter, :task_counter

    def initialize
      # Project specs
      @projects = {}
      @projects_counter = 0

      # Project relationships
      @project_membership = {}

      # Task specs
      @task = {}
      @task_counter = 0

      # Employee specs
      @employees = {}
      @employee_counter = 0
    end

    #  Project Methods

    def create_project(data)
      @projects_counter += 1
      data[:id] = @projects_counter
      data[:completed] = false
      create_membership(data[:id])
      @projects[data[:id]] = data
    end

    def get_project(id)
      project = @projects[id]
      project ? build_project(project) : false
    end

    def update_project(id, data)
      project = @projects[id]
      if project
        data.each { |key, value| project[key] = value }
      else
        false
      end
    end

    def destroy_project(id)
      @projects[id] ? @projects.delete(id) : false
    end

    def build_project(data)
      TM::Project.new(data)
    end

    # Project Query Methods

      def project_task(id, status)
        if @projects[id]
          task = []
          @task.each do |key, value|
            if status[:completed]
              task << build_task(value) if value[:pid] == id && value[:completed] == status[:completed]
            else
              task << build_task(value) if value[:pid] == id
            end
          end
          task.sort_by { |task_hash| task_hash.creation_date }
        else
          false
        end
      end

      def all_projects
        projects_array = []
        @projects.each do |key, value|
          projects_array << build_project(value)
        end
        projects_array
      end

    # Task Methods

    def create_task(data)
      @task_counter += 1
      data[:id] = @task_counter
      data[:completed] = false
      data[:eid] = false
      data[:creation_date] = Time.now
      @task[data[:id]] = data
    end

    def get_task(id)
      task = @task[id]
      task ? build_task(task) : false
    end

    def update_task(id, data)
      task = @task[id]
      if task
        data.each { |key, value| task[key] = value }
      else
        false
      end
    end

    def destroy_task(id)
      @task[id] ? @task.delete(id) : false
    end

    def build_task(data)
      TM::Task.new(data)
    end

  # Employee Methods

  def create_employee(data)
    @employee_counter += 1
    data[:id] = @employee_counter
    @employees[data[:id]] = data
  end

  def get_employee(id)
    employee = @employees[id]
    employee ? build_employee(employee) : false
  end

  def update_employee(id, data)
    employee = @employees[id]
    if employee
      data.each { |key, value| employee[key] = value if employee.has_key?(key) }
    else
      false
    end
  end

  def destroy_employee(id)
    @employees[id] ? @employees.delete(id) : false
  end

  def build_employee(data)
    TM::Employee.new(data)
  end

    # Employee Query Methods
    def all_employees
      employees_array = []
      @employees.each { |key, value| employees_array << build_employee(value) }
      employees_array
    end

  # Project Membership Methods

  def create_membership(id)
    @project_membership[id] = {}
  end

  def get_membership(id)
    @project_membership[id]
  end

  def update_membership(params)
    if params[:add]
      @project_membership[params[:pid]][params[:eid]] = true
    else
      @project_membership[params[:pid]].delete(params[:eid])
    end
  end

  def destroy_membership(id)
    @project_membership[id] ? @project_membership.delete(id) : false
  end


  end

  def self.db
    @__db_instance ||= Database.new
  end
end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/employee.rb'
require_relative 'task-manager/projectsmanager.rb'
require_relative 'task-manager/terminal.rb'

# t = TM::TerminalClient.new
# t.run_program
