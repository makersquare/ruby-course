require_relative 'lib/task-manager.rb'

class TM::Terminal
  def initialize
    @db = TM::DB.new
  end

  def start
    puts "Welcome to Project Manager Pro®. What can I do for you today?"
    puts "\n"
    puts "\n"
    puts "Available Commands"
    puts "help - Show these commands again"
    puts "project list - List all projects"
    puts "project create NAME - Create a new project"
    puts "project show PID - Show remaining tasks for project PID"
    puts "project history PID - Show completed tasks for project PID"
    puts "project employees PID - Show employees participating in this project"
    puts "project recruit PID EID - Adds employee EID to participate in project PID"
    puts "task create PID PRIORITY DESC - Add a new task to project PID"
    puts "task assign TID EID - Assign task TID to employee EID"
    puts "task mark TID - Mark task TID as complete"
    puts "emp list - List all employees"
    puts "emp create NAME - Create a new employee"
    puts "emp show EID - Show employee EID and all participating projects"
    puts "emp details EID - Show all remaining tasks assigned to employee EID,\n"
    puts "                  along with the project name next to each task"
    puts "emp history EID - Show completed tasks for employee with id=EID"
    puts "\n"
    puts "Please type in choice"
    input = gets.chomp
    split = input.split(" ") # turns input into an array, separated by spaces
    # model = project
    model = split.shift # model represents either proj/task/emp, shift takes first index, then removes
    # action = create
    action = split.shift # action represents either show/history etc, shift now takes the first index, model wa removed
    args = split # the rest of the data, task id, employee id, project id etc.
    #args = ["fitness"] example of this.
    if model == "help"  # if first input is help, then run block
      start        # will display prompt and all choices again
    else
    # self.send("project_create", *["fitness"])
                #name of method here!"
      self.send("#{model}_#{action}", *args)  # send is just giving method to class, with input, and splat for potential many argument data
      start # will run start, with parameters above
    end




  end

  def project_list


      puts "\n"
      puts "List of projects"
      puts "PID Name"
      TM.db.list_all_proj.each do |projectid, project|
        puts projectid.to_s + " " + project.name
      end
  end

  def project_create(*name) # splat argument
# fly to the sky
    name = name.join(" ")  # join name by spaces? so can have a space in project name?
    created_proj = TM.db.create_project(name)
    puts "\n"
    puts "Created a new project: "
    puts "PID" + " " +  "Name"
    puts "  #{created_proj.id}" + " " + "#{created_proj.name}"
    puts "\n"
  end

  def project_show(pid)
    taskarray = TM.db.remaining_task_proj(pid.to_i)
    puts "list of remaining task for project with id #{pid}"
    puts "TID PRIORITY-NUM  COMPLETE DESCRIPTION"
    taskarray.each do |task|
      puts "#{task.id}     #{task.priority_num}           #{task.complete}    #{task.descr}"
    end
  end

  def project_history(pid)
    taskarray = TM.db.completed_task_proj(pid.to_i)
    puts "list of completed task for project with id #{pid}"
    puts "TID PRIORITY-NUM  COMPLETE DESCRIPTION"
    taskarray.each do |task|
      puts "#{task.id}     #{task.priority_num}           #{task.complete}    #{task.descr}"
    end
  end

  def project_recruit(pid,eid)
    member = TM.db.add_membership(eid,pid)
    puts "Adding employee with id #{eid} to project with id #{pid}"
    puts member
  end

  def project_employees(pid)
    employees = TM.db.show_employees_for_proj(pid)
    puts "Showing employees for project with #{pid}"
    puts "EID NAME"
    employees.each do |employee|
      puts "#{employee.id}   #{employee.name}"
    end
  end

  def task_create(pid, priority_num, description)
    # binding.pry
    pid.to_i
    priority_num.to_i
    #  -->
    task = TM.db.create_task(pid,{:priority_num=>priority_num,:descr=>description})
    puts "\n"
    puts "Task created"
    puts "\n"
    puts "PID TID PRIORITY-NUM COMPLETE DESCRIPTION"
    puts "#{task.proj_id}    #{task.id}     #{task.priority_num}         #{task.complete}     #{task.descr}"

  end

  def task_assign(tid,eid)
    task = TM.db.assign_task_emp(tid,eid)
    puts "Assigned task with id #{tid} to employee with id #{eid}"
    puts "\n"

  end

  def emp_create(name)
    employee = TM.db.create_employee(name)
    puts "\n"
    puts "employee created"
    puts "\n"
    puts "EID NAME"
    puts "#{employee.id}   #{employee.name}"
  end

  def emp_list
    employee_list = TM.db.list_emp
    puts "\n"
    puts "List of employees"
    puts "EID Name"
    employee_list.each do|eid,emp|
      puts eid.to_s + "   " + emp.name
    end
  end

  def task_mark(tid)
    TM.db.mark_task_complete(tid)
    puts "Task with id #{tid} is marked compelete"
    puts "\n"
  end

  def emp_show(eid)
    projects = TM.db.show_projects_for_emp(eid)
    puts "All projects that employee with id #{eid} is working on"
    puts "ID NAME"
    projects.each do |project|
      puts "#{project.id}     #{project.name}"
    end
  end

  def emp_history(eid)
    taskarray = TM.db.completed_task_emp(eid)
    puts "Showing all completed task for employee with id #{eid}"
    puts "TID PRIORITY-NUM  COMPLETE DESCRIPTION"
    taskarray.each do |task|
      puts "#{task.id}     #{task.priority_num}           #{task.complete}    #{task.descr}"
    end
  end

  def emp_details(eid)
    taskarray = TM.db.remaining_task_emp(eid)
    puts "Showing all completed task for employee with id #{eid}"
    puts "TID PRIORITY-NUM  COMPLETE DESCRIPTION PROJECTNAME"
    taskarray.each do |task|
      puts "#{task.id}     #{task.priority_num}           #{task.complete}    #{task.descr}    #{TM.db.get_project(task.proj_id.to_i).name}"
    end
  end



end

tc = TM::Terminal.new

# puts "are you done with task-manager?"
# user_input = gets.chomp
tc.start
while true
  tc.start
  input = tc.start
  break if input == "quit"
end
