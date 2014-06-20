class TM::Client

  @@run = true

  def self.welcome
    puts "Welcome to Task Manager 2"
    help
  end

  def self.process_command(args)
    command = args.shift.to_sym
    sklass = args.shift.to_sym
    self.send(command, sklass, args)
  end

  def self.running?
    @@run
  end

  private

  def self.method_missing method, *args, &block
    puts "Invalid command."
    puts
  end

  def self.cmd_list
    [ '  help - Show these commands again',
      '  exit - Exit this application',
      '\n',
      '  create employees NAME EMAIL - Create a new employee',
      '  create projects NAME - Create a new project',
      '  create tasks PID EID PRIORITY DESC - Add a new task to project PID',
      '\n',
      '  show employees EID - Show employee EID and all participating projects',
      '  show employees EID COMPLETED - Show completed tasks for employee EID',
      '  show employees EID INCOMPLETE - Show remaining tasks and associated projects for employee EID',
      '  show projects PID - Show project PID and incomplete tasks',
      '  show projects PID COMPLETED - Show project PID and completed tasks',
      '  show projects PID EMPLOYEES - Show employees participating in this project',
      '  show tasks TID - Show task TID',
      '\n',
      '  list employees - Show all employees',
      '  list projects - Show all projects',
      '\n',
      '  recruit projects PID EID - Add employee EID to project PID',
      '  assign tasks TID EID - Assign task TID to employee EID',
      '\n',
      '  update tasks TID [PRIORITY=VALUE DESC=VALUE COMPLETED=VALUE] - Updates task TID with any or all of the supplied values',
      '  update employees EID [NAME=VALUE EMAIL=VALUE] - Updates employee EID with the supplied values',
      '  update projects PID NAME - Updates project PID with the supplied value'
    ]
  end

  def self.help args = []
    str = "Available Commands:\n"
    str += cmd_list.join("\n")
    puts str
  end

  def self.create(sklass, args = [])
    create_args = {}

    case sklass
    when 'employees', 'projects'
      create_args['name' ] = args[0]
      create_args['email'] = args[1] if args[1]
    when 'tasks'
      create_args['project_id' ] = args[0]
      create_args['employee_id'] = args[1]
      create_args['priority'   ] = args[2]
      create_args['description'] = args[3]
    end

    result = TM.db.create(sklass, create_args)

    display [ result ]
  end

  def self.show(sklass, args = [])
    case sklass
    when 'employees'
      employee_id = args[0]
      type        = args[1]

      case type
      when 'COMPLETED'
      when 'INCOMPLETE'
      end
    when 'projects'
      project_id = args[0]
      type       = args[1]
    when 'tasks'
      task_id = args[0]
    end

    result = TM.db.create(sklass, create_args)

    display [ result ]
  end

  def self.display(result_array)
    result_array.each do |result|
      string_array = [ ]
      [:id, :name, :email, :description, :project_id,
       :employee_id, :priority, :completed, :created_at].each do |attrib|
        string_array.push("#{attrib}: #{result.call(attrib)}") if result.respond_to?(attrib)
      end

      string = string_array.join(" - ")
      puts string
    end
  end

#########################

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
      project_array.each do |project|
        puts "ID: #{project.id} - Name: #{project.name}"
      end
  end

  def self.create args
    if valid(args)
      name = args.join(' ')

      project = TM::Project.new(name)

      show_projects [ project ]
    end
  end

  def self.show args
    if valid(args)
      project_id = args.first.to_i

      project = TM::Project.find(project_id)

      task_array = project.incompleted_tasks

      puts "Showing Project: #{project.name}"
      puts

      show_tasks task_array
    end
  end

  def self.show_tasks task_array
    task_array.each do |task|
      puts "ID: #{task.id} - Priority: #{task.priority} - Description: #{task.description}"
    end
  end

  def self.history args
    if valid(args)
      project_id = args.first.to_i

      project = TM::Project.find(project_id)

      task_array = project.completed_tasks

      puts "Showing Project: #{project.name}"
      puts

      show_tasks task_array
    end
  end

  def self.add args
    if valid(args)
      project_id  = args[0].to_i
      priority    = args[1].to_i
      description = args[2..-1].join(' ')

      task = TM::Task.new project_id, priority, description

      show_tasks [ task ]
    end
  end

  def self.mark args
    if valid(args)
      task_id = args.first.to_i

      task = TM::Task.find(task_id)

      task.complete

      show_tasks [ task ]
    end
  end

  def self.exit args = []
    puts "exiting"
    @@run = false
  end

  def self.valid args
    if args.empty?
      puts "Invalid arguments"
      false
    else
      true
    end
  end
end
