require 'pry'

# Create our module. This is so other files can start using it immediately
module TM
  class Database

    attr_reader :projects, :task, :employees, :employee_projects, :employee_counter, :projects_counter, :task_counter

    def initialize
      # Project specs
      @projects = {}
      @projects_counter = 0

      # Project relationships
      @employee_projects = {}
      @ep_counter = 0

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
      data[:eid] = nil
      data[:creation_date] = Time.now
      # binding.pry
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

      def employee_task(query_data)
        return false if !@employees[query_data[:eid]]
        task = []
        # binding.pry
        @task.each do |key, value|
          if query_data[:completed]
            task << build_task(value) if value[:eid] == query_data[:eid] && value[:completed]
          else
            task << build_task(value) if value[:eid] == query_data[:eid] && !value[:completed]
          end
        end
        # binding.pry
        task
      end

    # Project Membership Methods

    def create_membership(membership_data)
      if @employees[membership_data[:eid]] && @projects[membership_data[:pid]]
        @ep_counter += 1
        @employee_projects[@ep_counter] = {}
        @employee_projects[@ep_counter][:id] = @ep_counter
        @employee_projects[@ep_counter][:pid] = membership_data[:pid]
        @employee_projects[@ep_counter][:eid] = membership_data[:eid]
      end
    end

    def get_membership(id)
      employees = []
      @employee_projects.each do |key, value|
        if value[:pid] == id
          employees << value[:eid]
        end
      end
      # binding.pry
      employees
    end

    def update_membership(data)
      if data[:add]
        create_membership(pid: data[:pid] , eid: data[:eid])
      else
        @employee_projects.each do |key, value|
          if value[:pid] == data[:pid] && value[:eid] == data[:eid]
            @employee_projects.delete(key)
          end
        end
      end
    end

    def destroy_membership(membership_data)
      relation_destroy = []
      @employee_projects.each do |key, value|
        if value[:pid] == membership_data[:pid] && value[:eid] == membership_data[:eid]
          relation_destroy << key
        end
      end
      destroy_helper(relation_destroy)
    end

    def destroy_helper(array)
      if array.empty?
        false
      else
        array.each do |id|
          @employee_projects.delete(id)
        end
      end
    end

    #Project Membership Add and remove methods

      def projects_for_employee(employee_data)
        projects = []
        @employee_projects.each do |key, value|
          projects << get_project(value[:pid]) if value[:eid] == employee_data[:eid]
        end
        projects
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
require_relative 'task-manager/employeeprojects.rb'
require_relative 'task-manager/terminal2.rb'

t = TM::TerminalClient.new
t.run
# t.create_project(name: "My first project")
# t.create_project(name: "Second Project")
# t.list_projects
# t.create_task(priority: 1, description: "Task 1", pid: 1)
# t.create_task(description: "Task 2", pid: 1, priority: 2)
# t.create_employee(name: "Jacoub")
# t.assign_project_employee(eid: 1, pid: 1)
# t.assign_task_employee(eid: 1, tid: 1)
# t.project_remaining_task(id: 1)
# t.mark_task_complete(tid: 1)
# t.project_completed_task(id: 1)
# t.project_employees(id: 1)
# t.show_all_employees
# t.show_projects_employee(id: 1)
# t.remaining_task_employee(id: 1)
# t.completed_task_employee(id: 1)

