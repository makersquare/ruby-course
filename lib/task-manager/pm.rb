class PM

  def main_menu
    exit = false

    while !exit do
      # Show the menu and get the input
      puts "\n\n\nWelcome to Badass Manager Pro.  Whatya want??\n\n"
      puts"You can:"
      puts"\tadd project -- add a project\n"
      puts"\tadd task -- take a wild guess, dude.\n"
      puts"\thelp -- show this screen again\n"
      puts"\tilst -- list all projects\n"
      puts"\tshow PID - Show remaining tasks for project with id=PID\n"
      puts"\thistory PID - Show completed tasks for project with id=PID\n"
      puts"\tmark TID - Mark task with id=TID as complete\n"
      puts"\tquit -- quit this program\n\n"
      print"> "
      choice = gets.chomp.downcase

      # take care of those pesky 2 word ones.
      if choice.split(' ').size > 1
        choice_array = choice.split(' ')
        case choice_array[0]
        when "show"
          self.show(choice_array[1])
        when "history"
          self.history(choice_array[1])
        when "mark"
          self.mark(choice_array[1])
        when "add"
          if choice_array[1] == "project"
            self.add_project
          elsif choice_array[1] == "task"
            self.add_task
          else
            puts "Add what, dude?"
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
        else
          puts "Try again, Fat Fingers.\n"
        end

      end  #end if

    end  #end while

  end  #end main_menu

  def show(project_id)
    puts "stub of show(project_id)"
  end

  def history(project_id)
    puts "stub of history(project_id)"
  end

  def mark(task_id)
    puts "stub of mark(task_id)"
  end

  def add_project
    puts "stub of add_project"
  end

  def add_task
    puts "stub of add_task"
  end

  def list_projects
    puts "\n\nOk, here's a list of your current projects:\n\n"

      printf("%-10s %10s", )
  end

  def help
    puts "stub of help"
  end

end


manager = PM.new
manager.main_menu






