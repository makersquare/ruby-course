class TM::Client

  @@run = true

  def self.welcome
    puts "Welcome to Task Manager."
    help
  end

  def self.process_command(cmd)
    args = Array(cmd)
    command = args.shift.to_sym

    self.send(command, args)
  end

  def self.running?
    @@run
  end

  private

  def self.method_missing method, *args, &block
    puts "Invalid command."
    puts

    help
  end

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

  def self.help args = []
    str = "Available Commands:\n"
    str += cmd_list.join("\n")
    puts str
  end

  def self.list args = []
    projects = TM::Project.all
    if projects.empty?
      puts "No Projects"
    else
      puts "All Projects:"
      puts

      show_projects projects
    end
  end

  def self.show_projects project_array
      projects.each do |project|
        puts "ID: #{project.id} - Name: #{project.name}"
      end
  end

  def self.create args
    name = args.first

    project = TM::Project.new name
    show_projects [ project ]
  end

  def self.show args
    project_id = args.first.to_i

    project = TM::Project.find(project_id)

    task_array = project.incompleted_tasks

    puts "Showing Project: #{project.name}"
    puts

    show_tasks task_array
  end

  def self.show_tasks task_array
    task_array.each do |task|
      puts "ID: #{task.id} - Priority: #{task.priority} - Name: #{task.description}"
    end
  end

  def self.history args
    project_id = args.first.to_i

    project = TM::Project.find(project_id)

    task_array = project.completed_tasks

    puts "Showing Project: #{project.name}"
    puts

    show_tasks task_array
  end

  def self.add args
    project_id  = args[0].to_i
    priority    = args[1].to_i
    description = args[2..-1].join(' ')

    task = TM::Task.new project_id, priority, description

    show_tasks [ task ]
  end

  def self.mark args
    task_id = args.first.to_i

    task = TM::Task.find(task_id)

    task.complete

    show_tasks [ task ]
  end

  def self.exit args = []
    puts "exiting"
    @@run = false
  end
end
