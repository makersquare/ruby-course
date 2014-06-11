
require "pry-debugger"
require_relative "./lib/task-manager.rb"

class String
  def is_number?
    true if Float(self) rescue false
  end
end



class TerminalClient
  def initialize
    puts "Welcome to Project Manager Pro®. What can I do for you today?"
    help
  end


#these methods are to test and convert user entries
  def change_to_string(command_array,position_of_first_element=1,position_of_last_element=-1)
    command_array[position_of_first_element..position_of_last_element].join(' ')
  end

  def change_to_number(command_array,position_of_number_to_convert=1)
    command_array[position_of_number_to_convert].to_i
  end

  def check_number(command_array,position_of_number_to_convert=1)
    command_array[position_of_number_to_convert].is_number?
  end

  def check_error(command_array,location=1)
    command_array[location].nil?
  end

  def check_projects(project_id)
    !TM::Project.library[project_id].nil?
  end

  def check_tasks(project_id,task_id)
    !TM::Project.library[project_id].tasks[task_id].nil?
  end

  def throw_error
    multi_word_command_selector('error',"error")
  end
#these methods tests the vaildity with regard to he projects

#these methods take the user command and activate the correct command method
  def command_selector(user_input)
    command_array = user_input.split{/' '/}

    case command_array[0]
    when "help"
      help
    when "list"
      list
    when "create"
      if check_error(command_array)
        multi_line_command_selector('error')
      else
        name_of_project = change_to_string(command_array)
        create(name_of_project)
      end
    when "exit"
      puts "Goodbye!"
    else
      if check_error(command_array)
        throw_error
      elsif check_number(command_array)
        project_id = change_to_number(command_array)
        multi_word_command_selector(command_array,project_id)
      else
        throw_error
      end
    end
  end

  def multi_word_command_selector(command_array,project_id)
    case command_array[0]
      when "show"
        show(project_id) #shows remaining tasks for a project
      when "history"
        history(project_id)
      when "add" #adds a task to a project
        if (!check_error(command_array,2) && check_number(command_array,2))
            task_priority = change_to_number(command_array, 2)
            task_description = change_to_string(command_array, 3)
          if !check_error(command_array,3) && check_projects(project_id)
            add(project_id,task_priority,task_description)
          else
            throw_error
          end
        else
          multi_word_command_selector('error','error')
        end
      when "mark"
        if !check_error(command_array,2)&&check_number(command_array,2)
            task_id = change_to_number(command_array, 2)
          if check_projects(project_id) && check_tasks(project_id,task_id)
            mark(project_id, task_id)
          else
            throw_error
          end
        else
          throw_error
        end
      else
        puts "That was not a valid command."
        help
      end
    end


# these methods are the command methods
  def help
    puts "Available Commands:
      help - Show these commands again
      list - List all projects
      create NAME - Create a new project with name=NAME
      show PID - Show remaining tasks for project with id=PID
      history PID - Show completed tasks for project with id=PID
      add PID PRIORITY DESC - Add a new task to project with id=PID
      mark PID TID - Mark task with PID TID (project_id task_id) as complete"
    command_selector(gets.chomp)
  end

  def list
    puts "Showing all projects"
    puts "PID           Name"
    TM::Project.library.each do |existing_project|
      puts "#{existing_project.id}              #{existing_project.name}"
    end
    command_selector(gets.chomp)
  end

  def create project_name
    TM::Project.new(project_name)
    puts "Project #{project_name} has been created.
    #{TM::Project.library[-1].id} is the Project ID (PID)"
    command_selector(gets.chomp)
  end

  def show project_id
    puts "Showing tasks for Project #{TM::Project.library[project_id].name}"
    puts "Priority   TID  Description"
    TM::Project.library[project_id].list_incomplete_tasks.each do |task|
      puts "#{task.priority}          #{task.id}      #{task.description}"
    end
    command_selector(gets.chomp)
  end

  def history project_id
    puts "Showing completed tasks for Project #{TM::Project.library[project_id].name}"
    puts "Date created                        ID  Description"
    TM::Project.library[project_id].list_complete_tasks.each do |task|
      puts "#{task.creation_date.asctime}            #{task.id}   #{task.description}"
    end
    command_selector(gets.chomp)
  end

  def add(project_id, task_priority, task_description)
    TM::Project.library[project_id].add_task(task_description,task_priority)
    puts " A new task has been created for project #{TM::Project.library[project_id].name}.
    #{TM::Project.library[project_id].tasks[-1].id} is the Task ID (TID)
    The description is :
    #{task_description}"
    command_selector(gets.chomp)
  end

  def mark(project_id,task_id)
    TM::Project.library[project_id].complete_task(task_id)
    puts "Congratulations you have completed a task in #{TM::Project.library[project_id].name}
    the task id number was #{task_id} and the description was:
    #{TM::Project.library[project_id].tasks[task_id].description}"
    command_selector(gets.chomp)
  end

end

TerminalClient.new

