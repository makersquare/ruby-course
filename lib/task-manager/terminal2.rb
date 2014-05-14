require 'pry'

class TM::TerminalClient

  def initialize
    @db = TM.db
  end

  # Project Methods

  def list_projects
    puts "PID   Name"
    TM.db.all_projects.each do |project|
        puts " #{project.id}    #{project.name}"
    end
  end

  def create_project(project_data)
    if @db.create_project(name: project_data[:name])
      puts "Project Created"
      # binding.pry
    end
  end

  def assign_project_employee(employee_data)
    if @db.add_employee_to_project(eid: employee_data[:eid], pid: employee_data[:pid])
      puts "Employee assigned to project #{employee_data[:pid]}"
    end
  end

  # Task Methods

  def create_task(task_data)
    if @db.create_task(description: task_data[:desc], pid: task_data[:pid])
      puts "Task Created"
      # binding.pry
    end
  end

  def assign_task_employee(eid: 1, tid: 1)
  end

  # Employee Methods

  def create_employee(employee_data)
    if @db.create_employee(name: employee_data[:name])
      puts "Employee Created"
      # binding.pry
    end
  end

  def test
    puts "Working"
  end

end

# def list_instructions
#   puts "Available Commands:"
#   puts
#   puts "  help - Show these commands again"
# end
