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
      '  show employees - Show all employees',
      '  show employees EID - Show employee EID and all participating projects',
      '  show employees EID COMPLETED - Show completed tasks for employee EID',
      '  show employees EID INCOMPLETE - Show remaining tasks and associated projects for employee EID',
      '\n',
      '  show projects - Show all projects',
      '  show projects PID - Show project PID and incomplete tasks',
      '  show projects PID COMPLETED - Show project PID and completed tasks',
      '  show projects PID EMPLOYEES - Show employees participating in this project',
      '\n',
      '  show tasks TID - Show task TID',
      '\n',
      '  recruit projects PID EID - Add employee EID to project PID',
      '  assign tasks TID EID - Assign task TID to employee EID',
      '\n',
      '  update tasks TID [PRIORITY=VALUE DESC=VALUE COMPLETED=VALUE] - Updates task TID with any or all of the supplied values',
      '  update employees EID [NAME=VALUE EMAIL=VALUE] - Updates employee EID with the supplied values',
      '  update projects PID [NAME=VALUE COMPLETED=VALUE] - Updates project PID with the supplied values'
    ]
  end

  def self.help args = []
    str = "Available Commands:\n"
    str += cmd_list.join("\n")
    puts str
  end

  def self.create_employees(sklass, args = [])
    create_args = {}

    create_args['name' ] = args[0]
    create_args['email'] = args[1] if args[1]

    result = TM.db.create(sklass, create_args)
    display [ result ]
  end

  def self.create_projects(sklass, args = [])
    create_args = {}

    create_args['name'] = args[0]

    result = TM.db.create(sklass, create_args)
    display [ result ]
  end

  def self.create_tasks(sklass, args = [])
    create_args = {}

    create_args['project_id' ] = args[0]
    create_args['employee_id'] = args[1]
    create_args['priority'   ] = args[2]
    create_args['description'] = args[3]

    result = TM.db.create(sklass, create_args)
    display [ result ]
  end

  # def self.create(sklass, args = [])
  #   create_args = {}

  #   case sklass
  #   when 'employees', 'projects'
  #     create_args['name' ] = args[0]
  #     create_args['email'] = args[1] if args[1]
  #   when 'tasks'
  #     create_args['project_id' ] = args[0]
  #     create_args['employee_id'] = args[1]
  #     create_args['priority'   ] = args[2]
  #     create_args['description'] = args[3]
  #   end

  #   result = TM.db.create(sklass, create_args)

  #   display [ result ]
  # end

  def self.show_employees(sklass, args = [])
    employee_id = args[0]
    type        = args[1]

    if employee_id.nil?
      employees = TM.db.find(sklass, {})
      display employees
    else
      employee = TM.db.show(sklass, employee_id)
      display [ employee ]

      case type
      when 'COMPLETED'
        tasks = TM.db.find('tasks', {'employee_id' => employee_id, 'completed' => true})
        display tasks
      when 'INCOMPLETE'
        tasks = TM.db.find('tasks', {'employee_id' => employee_id, 'completed' => false})
        display tasks
      else
        projects = TM.db.find('projects', {'employee_id' => employee_id})
        display projects
      end
    end
  end

  def self.show_projects(sklass, args = [])
    project_id = args[0]
    type       = args[1]

    if project_id.nil?
      projects = TM.db.find(sklass, {})
      display projects
    else
      project = TM.db.show(sklass, project_id)
      display [ project ]

      case type
      when 'COMPLETED'
        tasks = TM.db.find('tasks', {'project_id' => project_id, 'completed' => true})
        display tasks
      when 'EMPLOYEES'
        # TODO Not sure how to construct this SQL
        # employees = TM.db.find('employees', {'project_id' => project_id})
        display employees
      else
        tasks = TM.db.find('tasks', {'project_id' => project_id, 'completed' => false})
        display tasks
      end
    end
  end

  def self.show_tasks(sklass, args = [])
    task_id = args[0]

    task = TM.db.show(sklass, task_id)
    display [ task ]
  end

  # def self.show(sklass, args = [])
  #   case sklass
  #   when 'employees'
  #     employee_id = args[0]
  #     type        = args[1]

  #     case type
  #     when 'COMPLETED'
  #     when 'INCOMPLETE'
  #     end
  #   when 'projects'
  #     project_id = args[0]
  #     type       = args[1]
  #   when 'tasks'
  #     task_id = args[0]
  #   end

  #   result = TM.db.create(sklass, create_args)

  #   display [ result ]
  # end

  def self.recruit_projects(sklass, args = [])
    project_id  = args[0]
    employee_id = args[1]

    result = TM.db.recruit(sklass, {'project_id' => project_id, 'employee_id' => employee_id})
# TODO this is not finished
    # show projects PID EMPLOYEES (display employees associated with this project)
    display [ result ]
  end

  def self.update_tasks(sklass, args = [])
    task_id = args.shift
    update_args = {}

    args.each do |arg|
      match = /^(.+)[=](.+)/.match(arg)
      key   = match[1]
      value = match[2]

      case key.upcase
      when 'EID'
        update_args['employee_id'] = value.to_i
      when 'PRIORITY'
        update_args['priority'] = value.to_i
      when 'DESC'
        update_args['description'] = value
      when 'COMPLETED'
        update_args['completed'] = value
      end
    end

    result = TM.db.update(sklass, task_id, update_args)
    display [ result ]
  end

  def self.update_employees(sklass, args = [])
    employee_id = args.shift
    update_args = {}

    args.each do |arg|
      match = /^(.+)[=](.+)/.match(arg)
      key   = match[1]
      value = match[2]

      case key.upcase
      when 'NAME'
        update_args['name'] = value
      when 'EMAIL'
        update_args['email'] = value
      end
    end

    result = TM.db.update(sklass, employee_id, update_args)
    display [ result ]
  end

  def self.update_projects(sklass, args = [])
    project_id = args.shift
    update_args = {}

    args.each do |arg|
      match = /^(.+)[=](.+)/.match(arg)
      key   = match[1]
      value = match[2]

      case key.upcase
      when 'NAME'
        update_args['name'] = value
      when 'COMPLETED'
        update_args['completed'] = value
      end
    end

    result = TM.db.update(sklass, project_id, update_args)
    display [ result ]
  end

  # '  assign tasks TID EID - Assign task TID to employee EID',
  # def self.assign_task(sklass, args = [])
  #   task_id     = args[0]
  #   employee_id = args[1]
  # end

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
