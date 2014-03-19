
require_relative '../task-manager.rb'


class TM::PM
  @exit = false


  def main_menu

    while !@exit do
      puts "    Welcome to the Project Manager"
      puts "    Available Commands:"
      puts "      help - Show these commands again"
      puts "      list - List all projects"
      puts "      create Name - Create a new project with NAME"
      puts "      show PID - Show remaining tasks for project with PID(ProjectID)"
      puts "      history PID - Show completed tasks for project with PID(ProjectID)"
      puts "      addtask PID - Add a new task to project using the PID(ProjectID)"
      puts "      mark PID TID - Mark a task in its project with its TID(TaskID) as complete"
      puts "      quit -- get out of the progam"
      puts "    What can I do for you today?"
      userinput = gets.chomp.downcase
      puts "Command Accepted '#{userinput}'"
      parseInput(userinput)
    end
  end

  def parseInput(userInput)
    parsedInput = userInput.split( " " )

    runCommand(parsedInput[0], parsedInput[1], parsedInput[2])
  end

  def thatUniqueProject(projectID)
    TM::Project.uniqueProjectArray.each { |index|
      if index.uniqueId == projectID.to_i
        @projectInstance = index
        return @projectInstance
      end
    }
    puts "Cant find project instance with that ID"
  end



  def runCommand(input1, input2, input3)
    if input1 == 'help'
      return
    elsif input1 == 'list'
      arrayofProjects = TM::Project.uniqueProjectArray
      arrayofProjects.each { |x|
        puts "PROJECT NAME: '#{x.projectName}' ID: '#{x.uniqueId}'" }

    elsif input1 == 'create'
      newproject = TM::Project.new(input2)
      puts "Created #{newproject}, good luck!"

    elsif input1 == 'show'
      thatUniqueProject(input2).taskArray.each { |x|
            puts "#{x.taskName}, #{x.description}, #{x.uniqueTaskId}, #{x.priority}, #{x.status}, #{x.creationTime}."
            found = true
            return
      }
      puts "So many projects"

    elsif input1 == 'history'
      thatUniqueProject(input2)
      @projectInstance.addTask
      puts @projectInstance.completedTaskArray

    elsif input1 == 'addtask'
      thatUniqueProject(input2)
      puts "What should your projects Title be?"
      name = gets.chomp
      puts "Describe your Project in one sentence"
      description = gets.chomp
      @projectInstance.addTask(name, description, input3)

    elsif input1 == 'mark'
      thatUniqueProject(input2)
      status = "completed"
      @projectInstance.changeStatus(input3, status)

    elsif input1 == 'quit'
      @exit = true

    end



  end
end


datterminal = TM::PM.new
datterminal.main_menu
