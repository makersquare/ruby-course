class TM::Client

  @@run = true

  def self.welcome
    puts "Welcome to Task Manager."
    help
  end

  def self.process_command(cmd)
    args = Array(cmd)
    command = args.shift

    case(command)
      when "help"
        help
      when "list"
        list TM::Project.all
      when "create"
        create args.first
      when "show"
        show args.first
      when "history"
        history args.first
      when "add"
        add args[0], args[1], args[2]
      when "mark"
        mark args.first
      when "exit"
        puts "exiting"
        @@run = false
      else
        invalid
    end
  end

  def self.running?
    @@run
  end

  private

  def self.cmd_list
    [ '  help - Show these commands again',
      '  exit - Exit this application',
      '  list - List all projects',
      '  create NAME - Create a new project with name=NAME',
      '  show PID - Show remaining tasks for project with id=PID',
      '  history PID - Show completed tasks for project with id=PID',
      '  add PID PRIORITY DESC - Add a new task to project with id=PID',
      '  mark TID - Mark task with id=TID as complete' ]
  end

  def self.help
    str = "Available Commands:\n"
    str += cmd_list.join("\n")
    puts str
  end

  def self.list project_array
    puts "All Projects:"

    project_array.each do |project|
      puts "ID: #{project.id} - Name: #{project.name}"
    end
  end

  def self.create name

  end

  def self.show project_id

  end

  def self.history project_id

  end

  def self.add project_id, priority, description

  end

  def self.mark task_id

  end

  def self.invalid
    puts "Invalid command."
    help
  end
end
