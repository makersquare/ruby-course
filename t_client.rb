require_relative './lib/task-manager.rb'

class Client
  attr_accessor :quit, :commands

  def self.initialize
    @quit = 'n'
    @commands = {
      'q' => :quit,
      'list' => :list,
      'create' => :create,
      'show' => :show,
      'history' => :history,
      'add' => :add,
      'complete' => :complete,
      'help' => :help
    }

    Client.help

    until @quit == 'q'

      puts "Please enter a command:"
      command = gets.chomp
      Client.execute_command(command)
    end
  end

  def self.execute_command(command)
    # splits the command into an array of strings, grabs the
    # first word, creates a hash with the rest of the words
    # with the keys being the arrays index
    execute = command.split(' ')
    command = execute.shift
    args = {}
    execute.each_with_index { |x, i| args[i.to_s.to_sym] = x }

    # Checks to see if the command is valid and then uses the
    # command hash to call the class method
    if @commands[command] != nil
      Client.send(@commands[command], args)
    else
      puts 'Not a command. Try again'
    end
  end

  def self.quit(opt={})
    @quit = 'q'
  end

  def self.help(opt = {})
    puts "Welcome to Project Manager Pro®. What can I do for you today?\nAvailable Commands:\n\thelp - Show these commands again\n\tlist - List all projects\n\tcreate NAME - Create a new project with name=NAME\n\tshow PID - Show remaining tasks for project with id=PID\n\thistory PID - Show completed tasks for project with id=PID\n\tadd PID PRIORITY DESC - Add a new task to project with id=PID\n\tcomplete TID - Mark task with id=TID as complete"
  end

  def self.list(opt = {})
    TM::Project.projects.each { |x| puts x.name }
  end

  def self.create(opt = {})
    name = opt[:"0"]
    TM::Project.new(name)
    puts "You created a project called #{TM::Project.projects[(TM::Project.project_id) - 1].name}"
  end

  def self.show(opt = {})
    pid = opt[:"0"].to_s.to_i
    TM::Project.projects.at(pid).list_tasks.each { |v| puts v[1].description }
  end

  def self.history(opt = {})
    pid = opt[:"0"].to_s.to_i
    TM::Project.projects.at(pid).list_complete.each { |v| puts v[1].description }
  end

  def self.add(opt = {})
    pid = opt[:"0"].to_s.to_i
    priority = opt[:"1"].to_s.to_i
    desc = opt[:"2"]

    TM::Project.projects[pid].add_task(desc, priority)

    # rediculously long interpolation to find task name
    puts "You created a task: #{TM::Project.projects[pid].task_list[TM::Project.projects[pid].task_id].description} for project #{TM::Project.projects[pid].name}"
  end

  def self.complete(opt = {})
    tid = opt[:"0"]
    deconstuct = tid.split(".")
    pid = deconstuct[0].to_i

    TM::Project.projects[pid].task_list[tid].complete

    puts "You marked task: #{TM::Project.projects[pid].task_list[tid].description} as COMPLETE in project: #{TM::Project.projects[pid].name}"
  end
end

Client.initialize
