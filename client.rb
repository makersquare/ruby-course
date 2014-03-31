require_relative 'lib/task-manager.rb'
require 'pry-debugger'

module TM
  class Client

    def main_menu

      # show the menu
      self.help

      #loop input getting
      exit = false
      while !exit do
        # get the input
        print"> "
        choice_array = gets.chomp.downcase.split   #store the input in an array

        # if the user cusses, talk some shit back
        if (  (choice_array.include?("shit"))  ||
                (choice_array.include?("fuck"))  ||
                (choice_array.include?("damn"))  ||
                (choice_array.include?("fucking")) ||
                (choice_array.include?("asshole"))  ||
                (choice_array.include?("motherfucker")))
            puts self.smart_ass_remarker(["Keep it classy, now.",
                            "Angry aren't we?",
                            "Come on, I'm sure there are ladies present.",
                            "Real real clever, douchebag.",
                            "You kiss your imaginary girlfriend with that mouth?",
                            "Yeah, yeah you're real intimidating. Now let's get on with it.",
                            "I don't have to take this shit. I'm going back to my GUI.",
                            "Why don't you take your clumsy fingers somewhere else?",
                            "Hey, watch your mouth."])

        else   # if the user behaves themselves
          case choice_array[0]
          when "help"
            puts "\nOk listen up, then, I hate repeating myself....\n"
            puts "\nPress Enter to See the Main Menu AGAIN...\n"
            self.help
          when "project"
            case choice_array[1]
            when "list"
              self.list_projects
            when "create"
              self.add_project(choice_array[2..-1].join(' '))
            when "show"
              self.show(choice_array[2].to_i)
            when "history"
              self.history(choice_array[2].to_i)
            when "employees"
              self.show_assigned_employees(choice_array[2].to_i)
            when "assign"
              self.assign_employee_to_project(choice_array[2].to_i, choice_array[3].to_i)
            end

          when "task"
            case choice_array[1]
            when "create"
              self.create_task(choice_array[2].to_i, choice_array[4..-1].join(' '), choice_array[3].to_i)
            when "assign"
              self.assign_task(choice_array[2].to_i, choice_array[3].to_i)
            when "mark"
              self.mark(choice_array[2].to_i)
            end

          when "emp"
            case choice_array[1]
            when "list"
              self.list_employees
            when "create"
              self.create_employee(choice_array[2..-1])
            when "show"
              self.show_employee(choice_array[2].to_i)
            when "ongoing"
              self.show_employee_ongoing(choice_array[2].to_i)
            when "history"
              self.show_employee_history(choice_array[2].to_i)
            end

          when "load"
            self.load_me_up

          when "quit"
            exit = true
          end

        end  #end if
      end  #end while
    end  #end main_menu

    def help
      # Show the menu and get the input
      puts"\n\n\nWelcome to Badass Manager Pro.  Whatya want??\n\n"
      puts"You can:"
      puts"\thelp -- show this screen again\n"
      puts"\tproject list -- list all projects\n"
      puts"\tproject create NAME - Create a project\n"
      puts"\tproject show PID - Show project with ongoing tasks\n"
      puts"\tproject history PID - Show completed tasks for a project PID\n"
      puts"\tproject employees PID - Show employees participating in a project PID\n"
      puts"\tproject assign EID PID - Assign employee to project\n"
      puts"\ttask create PID PRIORITY DESC - Create a task\n"
      puts"\ttask assign TID EID - Create a task\n"
      puts"\ttask mark TID - Mark a task as finished\n"
      puts"\temp list - List all employees\n"
      puts"\temp create NAME - Create employee\n"
      puts"\temp show EID - Show employee EID and all participating projects\n"
      puts"\temp ongoing EID - Show all remaining tasks assigned to employee id,\n"
      puts"\t                  along with the project name next to each task."
      puts"\temp history EID - Show completed tasks for employee EID\n"
      puts"\tload me up -- Make a bunch of fake projects so you look busy.\n"
      puts"\tquit -- quit this program\n\n"
    end


    # def show(project_id)
    #   result = GetProject(project_id)
    #   if result.success? == false
    #     if result.error == :no_project_found
    #       puts "Project not found..."
    #     end
    #   else
    #     project = result[:project]
    #   end

    #   tasks_array = project.ongoing_tasks
    #   puts "\n\nProject: #{project.name}\n"
    #   puts "ID\tDescription\t\t\tPriority\n"
    #   puts "------------------------------------------------"
    #   tasks_array.each { | x | print("#{x.task_id}" + (' ' * (8 - x.task_id.to_s.length)) + # padding
    #                 "#{x.description}" + (' ' * (33 - x.description.length) +
    #                 "#{x.priority}\n")) }
    #   puts "\n"
    # end

    # def history(project_id)
    #   project = TM::DB.instance.all_projects[project_id]
    #   tasks_array = project.completed_tasks
    #   puts "\n\nProject: #{project.name}\n"
    #   puts "ID\tDescription\t\t\tPriority\n"
    #   puts "------------------------------------------------"
    #   tasks_array.each { | x | print("#{x.task_id}" + (' ' * (8 - x.task_id.to_s.length)) + # padding
    #                 "#{x.description}" + (' ' * (33 - x.description.length) +
    #                 "#{x.priority}\n")) }
    #   puts "\n"
    # end

    def assign_employee_to_project(employee_id, project_id)
      result = TM::Assign.run({employee_id: employee_id, project_id: project_id })
      if result.success?
        puts "\nEmployee #{employee_id} assigned to project: #{project_id}"
      elsif result.error == :employee_not_found
        puts "\nEmployee not found... try again"
      elsif result.error == :project_not_found
        puts "\nProject not found... try again"
      end
    end

    def mark(task_id)
      result = TM::MarkTask.run(task_id)
      if result.success?
        puts ("#{TM::GetTask.run(task_id).description} marked as completed.\n\n")
      elsif result.error == :task_not_found
        puts ("Task not found...\n\n")
      elsif result.error == :task_already_completed
        puts ("You have already completed that task... dummy.\n\n")
        puts smart_ass_remarker(["You must be real proud of yourself",
                                "Applause applause.",
                                "What took you so long?"])
      end
    end

    def add_project(name)
      result = CreateProject.run(name)
      if result.success? == true
        puts "Project Created\n"
      elsif result.error == :name_field_empty
        puts "Come on, man. You gotta include a name. Go back and try again.\n"
      end
    end

    def list_projects
      result = ListProjects.run
      if result.success? == true
        puts "\n\nOk, here's a list of your current projects:\n\n"
        puts"ID:\tTask:"
        puts"--------------------------"
        result[:projects_list].each { |k,v| print("#{k}" + (' ' * (8 - k.to_s.length))+ "#{v.name}\n") }
      elsif result.error == :no_projects_found
        puts "Gotta add some projects first...\n\n"
      end
    end


    def load_me_up    # loads up a couple projects with tasks for testing
      @kill_bob = TM::db.create_project("Kill Bob")
      @kill_sue = TM::db.create_project("Kill Sue")
      @kill_ted = TM::db.create_project("Kill Ted")
      @buy_milk = TM::db.create_project("Buy Milk")
      @buy_gun = TM::db.create_task({ project_id: 1, description: "Go buy a gun", priority: 3 })
      @load_gun = TM::db.create_task({ project_id: 1, description: "Load the gun", priority: 4 })
      @buy_knife = TM::db.create_task({ project_id: 2, description: "Buy a knife", priority: 5 })
      @sharpen_knife = TM::db.create_task({ project_id: 2, description: "Sharpen the knife", priority: 2 })
      @buy_chainsaw = TM::db.create_task({ project_id: 3, description: "Buy a chainsaw", priority: 2 })
      @sharpen_chainsaw = TM::db.create_task({ project_id: 3, description: "Sharpen the chainsaw", priority: 3 })
      @get_in_car = TM::db.create_task({ project_id: 4, description: "Get in the car", priority: 9 })
      @drive_to_store = TM::db.create_task({ project_id: 4, description: "Drive to the store", priority: 10 })
      @talk_to_clerk = TM::db.create_task({ project_id: 4, description: "Talk to clerk", priority: 4 })
      @pay_for_milk = TM::db.create_task({ project_id: 4, description: "Pay for milk", priority: 2 })
      TM::db.assign({ project_id: @kill_bob.id, task_id: @buy_gun.id })
      TM::db.assign({ project_id: @kill_bob.id, task_id: @load_gun.id })
      TM::db.assign({ project_id: @kill_sue.id, task_id: @buy_knife.id })
      TM::db.assign({ project_id: @kill_sue.id, task_id: @sharpen_knife.id })
      TM::db.assign({ project_id: @kill_ted.id, task_id: @buy_chainsaw.id })
      TM::db.assign({ project_id: @kill_ted.id, task_id: @sharpen_chainsaw.id })
      TM::db.assign({ project_id: @buy_milk.id, task_id: @get_in_car.id })
      TM::db.assign({ project_id: @buy_milk.id, task_id: @drive_to_store.id })
      TM::db.assign({ project_id: @buy_milk.id, task_id: @talk_to_clerk.id })
      TM::db.assign({ project_id: @buy_milk.id, task_id: @pay_for_milk.id })
      @employee1 = TM::db.create_employee("Bill")
      @employee2 = TM::db.create_employee("Rhonda")
      @employee3 = TM::db.create_employee("Phil")
      @employee4 = TM::db.create_employee("Martha")
      TM::db.assign({ project_id: @kill_bob, employee_id: @employee1 })
      TM::db.assign({ project_id: @kill_bob, employee_id: @employee2 })
      TM::db.assign({ project_id: @kill_bob, employee_id: @employee3 })
      TM::db.assign({ project_id: @kill_sue, employee_id: @employee4 })
      TM::db.assign({ project_id: @kill_sue, employee_id: @employee1 })
      TM::db.assign({ task_id: @buy_gun.id, employee_id: @employee1 })
      TM::db.assign({ task_id: @load_gun.id, employee_id: @employee1 })
      @buy_gun.finished = true
    end

    def create_task(project_id, description, priority)
      result = CreateTask.run({ project_id: project_id, description: description, priority: priority })
      if result.success? == true
        puts "\nNew task created!\n\n"
      elsif result.error = :no_project_found
        puts "No project with that id found... \n\n"
      elsif result.error == :no_description_provided
        puts "Give me a description, man.\n\n"
      elsif result.error == :no_priority_provided
        puts "Give me a priority level, please.\n\n"
      end
    end

    def assign_task(task_id, employee_id)
      result = TM::Assign.run({task_id: task_id, employee_id: employee_id })
      if result.success? == true
        puts "\nTask Assigned.\n"
      elsif result.error == :task_not_found
        puts "\nTask not found... Try again.\n"
      elsif result.error == :employee_not_found
        puts "\nEmployee not found... Try again.\n"
      elsif result.error == :employee_not_assigned_to_project
        puts "\nYou must assign that employee to the project first.\n\n"
      end
    end

    def create_employee(name)
      TM::CreateEmployee.run(name)
      puts "\nEmployee Created\n"
    end


    # def show_assigned_employees(project_id)
    #   # get the project
    #   project = TM::DB.instance.all_projects[project_id]

    #   # get the list
    #   employee_list = TM::DB.instance.project_employees(project_id)

    #   #display it beautifully :)
    #   puts "\n\n"
    #   puts "ID\tEmployee\n"
    #   puts "------------------------------------------------"
    #   employee_list.each { | x | print("#{x.employee_id}" + (' ' * (8 - x.employee_id.to_s.length)) + # padding
    #                 "#{x.name}" + "\n") }
    #   puts "\n"
    # end

    # def list_employees
    #   #get list
    #   employee_list = TM::DB.instance.all_employees.values.sort { |a,b| a.employee_id <=> b.employee_id }

    #   #display it beautifully :)
    #   puts "\nALL EMPLOYEES:\n\n"
    #   puts "ID\tEmployee\n"
    #   puts "------------------------------------------------"
    #   employee_list.each { | x | print("#{x.employee_id}" + (' ' * (8 - x.employee_id.to_s.length)) + # padding
    #                 "#{x.name}" + "\n") }
    #   puts "\n"
    # end

    # def show_employee(employee_id)
    #   # get employee
    #   employee = TM::DB.instance.all_employees[employee_id]

    #   # display employee info
    #   puts "\n\nEmployee:  #{employee.name}   ID:  #{employee.employee_id}\n\n"
    #   puts "    Projects:\n"
    #   puts "---------------------"

    #   # get projects array
    #   projects = TM::DB.instance.employee_projects(employee)

    #   if projects != nil
    #     projects.each { |x| puts "#{x.id}"  + (' ' * (5 - x.id.to_s.length)) +  "#{x.name}\n" }
    #   end
    #   puts "\n"
    # end

    # def show_employee_ongoing(employee_id)
    #   # get employee
    #   employee = TM::DB.instance.all_employees[employee_id]

    #   # display ongoing tasks
    #   puts "\n\n"
    #   puts "ID\tDescription\t\t\tPriority\n"
    #   puts "------------------------------------------------"
    #   TM::DB.instance.ongoing_tasks(employee).each { | x | print("#{x.task_id}" + (' ' * (8 - x.task_id.to_s.length)) + # padding
    #                 "#{x.description}" + (' ' * (33 - x.description.length) +
    #                 "#{x.priority}\n")) }
    #   puts "\n"
    # end

    def show_employee_history(employee_id)
      # get employee
      result = TM::GetEmployee(employee_id)
      if result.success?
        puts "ID\tDescription\t\t\tPriority\n"
        puts "------------------------------------------------"
        TM::DB.instance.completed_tasks(employee).each { | x | print("#{x.task_id}" + (' ' * (8 - x.task_id.to_s.length)) + # padding
                      "#{x.description}" + (' ' * (33 - x.description.length) +
                      "#{x.priority}\n")) }
        puts "\n"
      end

    def smart_ass_remarker(remarks)
      random = rand(remarks.length)
      return remarks[random]
    end

  end
end


manager = TM::Client.new
manager.main_menu
