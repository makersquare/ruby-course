require_relative '../task-manager.rb'

class TM::ProjectManager
  # definitely don't want to do this.. abstract later
  def initialize
    @projects = []
  end

  def start
    # will remove this later - will want to instantiate projects and tasks in terminal instead of in this method
    #
    # it's only here now for testing purposes
    project_1 = TM::Project.new("My Cool Project")
    @projects << project_1

    project_1.add_task("collect 20 hats", 2)
    project_1.add_task("watch a funny video", 3)
    project_1.add_task("sell rolex watch", 1)


    # found out this could be done by googling:
    # ruby multiline string
    terminal_prompt = <<-eos
Welcome to Project Manager Pro®. What can I do for you today?

Available Commands:
  help - Show these commands again
  list - List all projects
  show PID - Show remaining tasks for project with id=PID
  history PID - Show completed tasks for project with id=PID
  mark TID - Mark task with id=TID as complete
    eos

    puts terminal_prompt
    print ">"
    user_response = gets.chomp



    # splitting the user's response into an array separated by spaces
    #
    # will use the array to find what command they put in is, e.g. help, or show - it will be first element in the array
    #
    # also if there's a PID, we we will be able to find it in the next element of the array and use this to get the correct project or task
    #
    response_array = user_response.split(' ')

    # debugging - allows you to see what the response array looks like
    # p response_array

    if response_array[0] == "show"
      project = @projects.find { |proj| proj.id == response_array[1].to_i }
      # debugging - allows you to see what the project object looks like
      # p project
      project.list_incomplete_tasks.each do |incomplete_task|
        puts incomplete_task.description
      end
    end
  end
end

pm = TM::ProjectManager.new
pm.start

