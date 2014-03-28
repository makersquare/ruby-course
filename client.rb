require 'io/console'
require_relative './lib/task-manager.rb'

class Client

puts "Welcome to Project Manager Lite! What can I do for you today?"

projlist = TM::ProjectList.new
#loop through commands and input ; end loop when user says exit

    def comm_ls
      puts "Available Commands: "
      puts "\n"
      puts "help - Show these commands again"
      puts "list - List all projects"
      puts "create NAME - Create a new project with name=NAME"
      puts "show PID - Show remaining tasks for project with id=PID"
      puts "history PID - Show completed tasks for project with id=PID"
      puts "add PID PRIORITY DESC - Add a new task to project with id=PID"
      puts "mark TID - Mark task with id=TID as complete"

      puts "emp list - List all employees"
      puts "emp create NAME - Create a new employee"
      puts "emp show EID - Show employee EID and all participating projects"
      puts "emp details EID - Show all remaining tasks assigned to employee EID,
                    along with the project name next to each task"
      puts "emp history EID - Show completed tasks for employee with id=EID"
    end

    command = gets.chomp


# 1. use regex to test command var against available commands
# 2. parse IDs and other relevant information using regex
# 3. carry out project list commands using relevant data
    case
      when (command =~ /help/i)
        comm_ls

      when (command =~ /list/i)

        # should provide project name, id, number of completed out of
        # incomplete tasks, number of high priority incomplete tasks in project
        # format each item with a tab
        all_proj = projlist.show_all

        puts "Project Name \t Project ID \t #Completed Tasks \t High Priority Tasks Remaining"

        all_proj.each do |project|
          puts project.name + " \t " + project.id + " \t " + project.sort_comp.length + " \t " + project.hi_prio
        end

      when (command =~ /create/i)

        # should create a new project with name using the 'create NAME' command
        # 1. parse out NAME from create = first occurrence of whitespace + letter
        # 2. declare a new project in project list
        # THE PATTERN MATCH ASSUMES NO SPACES BEFORE 'create'

        match_ind = command =~ /\s\w/
        project_name = command[match_ind+1..-1]
        projlist.create_project(project_name)

        puts ("Your new project's name is: #{project_name}")

      when (command =~ /show/i)

        # show PID - Show remaining tasks for project with id=PID
        # 1. parse out ID number
        # 2. use get project to fetch project, show_inc to show incompletes
        # 3. return project's info in proper format (project name and other info)
        match_ind = command =~ /\s\d/
        project_id = command[match_ind+1..-1]

        proj = projlist.get_project(project_id)

        if (proj.class != String)
          proj_inc_arr = projlist.show_inc(project_id)
        # [[tasknumber, TASKobject], [tasknumber, TASKobject]]
          puts "Remaining Tasks in #{proj.name}"
          proj_inc_arr.each do |task|
            puts "Task number : #{task[0]} \t Priority: #{task[1].priority} \t Description #{task[1].description}"
          end

        else
          puts proj
        end


      when (command =~ /history/i)
      # show completed tasks for project with ID

        match_ind = command =~ /\s\d/
        project_id = command[match_ind+1..-1]

        proj = projlist.get_project(project_id)

        if (proj.class != String)
          proj_comp_arr = projlist.show_comp(project_id)
        # [[tasknumber, TASKobject], [tasknumber, TASKobject]]
          puts "Remaining Tasks in #{proj.name}"
          proj_comp_arr.each do |task|
            puts "Priority: #{task[1].priority} \t Description: #{task[1].description} \t Created: #{task[1].created.to_s}"
          end

        else
          puts proj
        end


      when (command =~ /add\b/i)
      # puts "add PID PRIORITY DESC - Add a new task to project with id=PID"
      # 1. parse the command for id, description, priority --
          # --control for errors in input
      # 2. input those values to the add_new_task, calling on projlist
      # 3. format those values apprpriately -"You added the following task to
      # Project NAME (ProjectID): task.priority, task.description, task.created

      pid_ind = command =~ /\s\d/ # match whitespace + number
      pid_ind += 1
      prio_ind = command =~ /\d\s\d/ # match number + whitespace + number (then +2) (priority numbers always single digit)
      prio_ind += 2
      desc_ind = command =~ /\s\w/  # match string + end of string
      desc_ind += 1

      pid = command[pid_ind..prio_ind]
      prio_num = command[prio_ind]
      desc = command[desc_ind..-1]
      task = projlist.add_new_task(pid, desc, prio_num)

      puts "You added the following task to Project #{projlist.get_project(pid)}: "
      puts "Priority: #{task.priority} \t Description: #{task.description} \t Created: #{task.created.to_s}"


      when (command =~ /mark/i)
       # puts "mark TID - Mark task with id=TID as complete"
       # 1. parse out the task id from the command
       # 2. submit the task id to the mark_task_c(task_id) method
       # 3. format the appropriate data: "You have marked the following task
       # as complete : project name, project id, task.priority, description, created at
       # --check for errors

       tid = command =~ /\s\d/
       tid += 1

       task = projlist.mark_task_c(tid)

       if task.class != String
          proj = projlist.get_project(task.projID)
          puts "You have marked the following task in #{proj.name}(project ID : #{proj.id})as complete: "
          puts "Priority: #{task.priority} \t Description: #{task.description} \t Created: #{task.created.to_s}"
       else
        puts task
       end


      when (command =~ /empp/i)

      when (command =~ /addemp/i)

      when (command =~ /rememp/i)

      else puts "Not an existing Project Manager command"

      end


end
