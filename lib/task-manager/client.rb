class TM::Client

  @@cuss_words_lines = [  "Keep it classy, fucker.",
                          "A little angry aren't we?",
                          "Come on, I'm sure there are ladies present.",
                          "Real real clever, asshole.",
                          "You kiss your imaginary girlfriend with that mouth?",
                          "Yeah, yeah you're real intimidating. Now let's get on with it.",
                          "I don't have to take this shit. I'm going back to my GUI.",
                          "Why don't you take your clumsy fingers somewhere else?",
                          "Hey, watch your mouth."]

  def main_menu


    exit = false
    while !exit do
      # Show the menu and get the input
      puts "\n\n\nWelcome to Badass Manager Pro.  Whatya want??\n\n"
      puts"You can:"
      puts"\tadd project -- add a project\n"
      puts"\tadd task -- take a wild guess, dude.\n"
      puts"\thelp -- show this screen again\n"
      puts"\tlist -- list all projects\n"
      puts"\tshow PID - Show remaining tasks for project with id=PID\n"
      puts"\thistory PID - Show completed tasks for project with id=PID\n"
      puts"\tmark TID - Mark task with id=TID as complete\n"
      puts"\tload me up -- Make a bunch of fake projects so you look busy.\n"
      puts"\tquit -- quit this program\n\n"
      print"> "
      choice = gets.chomp.downcase

      # take care of those pesky 2 word ones.
      if choice.split(' ').size > 1
        choice_array = choice.split(' ')
        case choice_array[0]
        when "show"
          self.show(choice_array[1].to_i)
        when "history"
          self.history(choice_array[1].to_i)
        when "load"
          self.load_me_up
        when "mark"
          self.mark(choice_array[1].to_i)
        when "add"
          if choice_array[1] == "project"
            self.add_project
          elsif choice_array[1] == "task"
            self.add_task
          else
            puts "Add what, dude?"
          end
        else
          if (  (choice_array.include?("shit"))  ||
                (choice_array.include?("fuck"))  ||
                (choice_array.include?("damn"))  ||
                (choice_array.include?("fucking")) ||
                (choice_array.include?("asshole"))  ||
                (choice_array.include?("motherfucker")))

            puts self.smart_ass_remarker(@@cuss_words_lines)
            gets
          end

        end

      else  #if it's just one word

        case choice
        when "help"
          puts "\nOk listen up, then, I hate repeating myself....\n"
        when "add project"
          self.help
        when "list"
          self.list_projects
        when "quit"
          puts "\n\nok fine be that way.\n\n"
          exit = true
        when "shit", "fuck", "fuck", "asshole", "damn", "motherfucker"
          puts self.smart_ass_remarker(@@cuss_words_lines)
          gets
        else
          puts "Try again, Fat Fingers.\n"
        end
      end  #end if

    end  #end while

  end  #end main_menu

  def show(project_id)
    project = TM::Project.all_projects[project_id]
    tasks_array = project.ongoing_tasks
    puts "\n\nProject: #{project.name}\n"
    puts "ID\tDescription\t\t\tPriority\n"
    puts "------------------------------------------------"
    tasks_array.each { | x | print("#{x.task_id}" + (' ' * (8 - x.task_id.to_s.length)) + # padding
                  "#{x.description}" + (' ' * (33 - x.description.length) +
                  "#{x.priority}\n")) }
    puts "\n"
    puts "Press Enter to Continue"
    gets
  end



  def history(project_id)
    project = TM::Project.all_projects[project_id]
    tasks_array = project.completed_tasks
    puts "\n\nProject: #{project.name}\n"
    puts "ID\tDescription\t\t\tPriority\n"
    puts "------------------------------------------------"
    tasks_array.each { | x | print("#{x.task_id}" + (' ' * (8 - x.task_id.to_s.length)) + # padding
                  "#{x.description}" + (' ' * (33 - x.description.length) +
                  "#{x.priority}\n")) }
    puts "\n"
    puts "Press Enter to Continue"
    gets
  end

  def mark(task_id)
    TM::Task.all_tasks[task_id].finished = true
    puts "#{TM::Task.all_tasks[task_id].description} marked as finished."
    puts smart_ass_remarker(["You must be real proud of yourself",
                            "Applause applause.",
                            "What took you so long?"])
    puts "\nPress Enter to Continue"
    gets
  end

  def add_project
    puts "And what are we going to call this new project? "
    name = gets.chomp!
    TM::Project.new(name)
    print "Project Created... Press Enter to Continue"
    gets
  end


  def add_task

    # keep asking the user for input until they enter a valid id
    project_id = nil
    until TM::Project.all_projects.keys.include?(project_id)
      print "Which project id would you like to add a task to? "
      project_id = gets.chomp!.to_i
    end

    puts "Ok... Adding to #{TM::Project.all_projects[project_id].name}..."
    print "Enter a task name: "
    description = gets.chomp!

    # abort add if they left it blank
    if description.empty?
      puts smart_ass_remarker(["Oh... cold feet, huh? Ok try again when you're feeling less timid.",
                            "Why don't you make up your mind and come back later.",
                            "Need a little more time with the menu?",
                            "Description too short. Please replace user.",
                            "Cat got your tongue?"])
      puts "Shall we move on?"
      gets
      return
    end

    priority = -1
    until (priority > 0) && (priority <= 10)
      print "Priority Level (1-10)? "
      priority = gets.chomp!.to_i
    end

    #create task and add it to project
    new_task = TM::Task.new(project_id, description, priority)
    TM::Project.all_projects[project_id].add_task(new_task)

    puts "\n\nYour task has been added."
    puts "Press Enter to Continue"
    gets
  end  # end add_task


  def list_projects
    puts "\n\nOk, here's a list of your current projects:\n\n"
    puts"ID:\tTask:"
    puts"--------------------------"
     # (8 - k.to_s.length) is to pad the string with spaces
     TM::Project.all_projects.each { |k,v| print("#{k}" + (' ' * (8 - k.to_s.length))+ "#{v.name}\n") }
    puts "\n\nPress Enter to Continue"
    gets
  end


  def load_me_up    # loads up a couple projects with tasks for testing
    @kill_bob = TM::Project.new("Kill Bob")
    @kill_sue = TM::Project.new("Kill Sue")
    @kill_ted = TM::Project.new("Kill Ted")
    @buy_milk = TM::Project.new("Buy Milk")
    @buy_gun = TM::Task.new(1, "Go buy a gun", 3)
    @load_gun = TM::Task.new(1, "Load the gun", 4)
    @buy_knife = TM::Task.new(2, "Buy a knife", 5)
    @sharpen_knife = TM::Task.new(2, "Sharpen the knife", 2)
    @buy_chainsaw = TM::Task.new(3, "Buy a chainsaw", 2)
    @sharpen_chainsaw = TM::Task.new(3, "Sharpen the chainsaw", 3)
    @get_in_car = TM::Task.new(4, "Get in the car", 9)
    @drive_to_store = TM::Task.new(4, "Drive to the store", 10)
    @talk_to_clerk = TM::Task.new(4, "Talk to clerk", 4)
    @pay_for_milk = TM::Task.new(4, "Pay for milk", 2)
    @kill_bob.add_task(@buy_gun)
    @kill_bob.add_task(@load_gun)
    @kill_sue.add_task(@buy_knife)
    @kill_sue.add_task(@sharpen_knife)
    @kill_ted.add_task(@buy_chainsaw)
    @kill_ted.add_task(@sharpen_chainsaw)
    @buy_milk.add_task(@get_in_car)
    @buy_milk.add_task(@drive_to_store)
    @buy_milk.add_task(@talk_to_clerk)
    @buy_milk.add_task(@pay_for_milk)
  end

  def smart_ass_remarker(remarks)
    random = rand(remarks.length)
    return remarks[random]
  end

end


#manager = TM::Client.new
#manager.main_menu
