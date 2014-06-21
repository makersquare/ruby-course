class TM::Client

  @@run = true

  def self.welcome
    puts "Welcome to Task Manager 2"
    help
  end

  def self.process_command(args)
    command = args.shift.to_sym

    if args.empty?
      self.send(command)
    else
      sklass  = args.shift.to_sym
      # self.send(command, sklass, args)
      self.send("#{command}_#{sklass}", sklass, args)
    end
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
      '  ',
      '  create employees NAME - Create a new employee',
      '  create projects NAME - Create a new project',
      '  create tasks PID EID PRIORITY DESC - Add a new task to project PID',
      '  ',
      '  show employees - Show all employees',
      '  show employees EID - Show employee EID and assigned project',
      '  show employees EID COMPLETED - Show completed tasks for employee EID',
      '  show employees EID INCOMPLETE - Show remaining tasks and associated projects for employee EID',
      '  ',
      '  show projects - Show all projects',
      '  show projects PID - Show project PID and incomplete tasks',
      '  show projects PID COMPLETED - Show project PID and completed tasks',
      '  show projects PID EMPLOYEES - Show employees participating in this project',
      '  ',
      '  show tasks TID - Show task TID',
      '  ',
      '  recruit projects PID EID - Add employee EID to project PID',
      '  assign tasks TID EID - Assign task TID to employee EID',
      '  ',
      '  update tasks TID [PRIORITY=VALUE COMPLETED=VALUE DESC=VALUE] - Updates task TID with any or all of the supplied values',
      '  update employees EID NAME=VALUE - Updates employee EID with the supplied values',
      '  update projects PID COMPLETED=VALUE NAME=VALUE - Updates project PID with the supplied values'
    ]
  end

  def self.help args = []
    str = "Available Commands:\n"
    str += cmd_list.join("\n")
    puts str
  end

  def self.create_employees(sklass, args = [])
    create_args = {}

    create_args['name'] = args.join(' ')

    results = TM.db.create(sklass, create_args)
    display results
  end

  def self.create_projects(sklass, args = [])
    create_args = {}

    create_args['name'] = args.join(' ')

    results = TM.db.create(sklass, create_args)
    display results
  end

  def self.create_tasks(sklass, args = [])
    create_args = {}

    create_args['project_id' ] = args.shift
    create_args['employee_id'] = args.shift
    create_args['priority'   ] = args.shift
    create_args['description'] = args.join(' ')

    results = TM.db.create(sklass, create_args)
    display results
  end

  def self.show_employees(sklass, args = [])
    employee_id = args[0]
    type        = args[1]

    if employee_id.nil?
      employees = TM.db.find(sklass, {})
      display employees
    else
      employees = TM.db.find(sklass, {'id' => employee_id})
      display employees

      type = type.upcase if type

      case type
      when 'COMPLETED'
        tasks = TM.db.find('tasks', {'employee_id' => employee_id, 'completed' => true})
        display tasks
      when 'INCOMPLETE'
        tasks = TM.db.find('tasks', {'employee_id' => employee_id, 'completed' => false})
        display tasks
      else
        project_id = employees.first.send(:project_id)
        projects = TM.db.find('projects', {'id' => project_id})
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
      projects = TM.db.find(sklass, {'id' => project_id})
      display projects

      type = type.upcase if type

      case type
      when 'COMPLETED'
        tasks = TM.db.find('tasks', {'project_id' => project_id, 'completed' => true})
        display tasks
      when 'EMPLOYEES'
        employees = TM.db.find('employees', {'project_id' => project_id})
        display employees
      else
        tasks = TM.db.find('tasks', {'project_id' => project_id, 'completed' => false})
        display tasks
      end
    end
  end

  def self.show_tasks(sklass, args = [])
    task_id = args[0]

    tasks = TM.db.find(sklass, {'id' => task_id})
    display tasks
  end

  def self.recruit_projects(sklass, args = [])
    project_id  = args[0]
    employee_id = args[1]

    employee = TM.db.update('employees', employee_id, {'project_id' => project_id})

    self.show_projects('projects', [project_id, 'EMPLOYEES'])
  end

  def self.update_tasks(sklass, args = [])
    task_id = args.shift
    update_args = {}
    valid = true

    args.each do |arg|
      args.shift
      match = /^(.+)[=](.+)/.match(arg)

      if match.nil?
        puts "Invalid arguments"
        valid = false
      else
        key   = match[1]
        value = match[2]

        key = key.upcase if key

        case key
        when 'EID'
          update_args['employee_id'] = value.to_i
        when 'PRIORITY'
          update_args['priority'] = value.to_i
        when 'COMPLETED'
          update_args['completed'] = value
        when 'DESC'
          update_args['description'] = value + " " + args.join(' ')
        end
      end
    end

    if valid
      results = TM.db.update(sklass, task_id, update_args)
      display results
    end
  end

  def self.update_employees(sklass, args = [])
    employee_id = args.shift
    update_args = {}
    valid = true

    args.each do |arg|
      args.shift
      match = /^(.+)[=](.+)/.match(arg)

      if match.nil?
        puts "Invalid arguments"
        valid = false
      else
        key   = match[1]
        value = match[2]

        key = key.upcase if key

        case key
        when 'NAME'
          update_args['name'] = value + " #{args.join(' ')}"
        end
      end
    end

    if valid
      results = TM.db.update(sklass, employee_id, update_args)
      display results
    end
  end

  def self.update_projects(sklass, args = [])
    project_id = args.shift
    update_args = {}
    valid = true

    args.each do |arg|
      args.shift
      match = /^(.+)[=](.+)/.match(arg)

      if match.nil?
        puts "Invalid arguments"
        valid = false
      else
        key   = match[1]
        value = match[2]

        key = key.upcase if key

        case key
        when 'COMPLETED'
          update_args['completed'] = value
        when 'NAME'
          update_args['name'] = value + " #{args.join(' ')}"
        end
      end
    end

    if valid
      results = TM.db.update(sklass, project_id, update_args)
      display results
    end
  end

  def self.display(result_array)
    respond_to_ary = []
    [:id, :name, :email, :description, :project_id,
     :employee_id, :priority, :completed, :created_at].each do |attrib|
      if result_array.first.respond_to?(attrib)
        respond_to_ary.push(attrib)
        # print "  #{attrib}"
        case attrib
        when :id, :project_id, :employee_id, :priority
          printf("%-12s", attrib)
        when :name, :email
          printf("%-20s", attrib)
        when :completed
          printf("%-12s", attrib)
        else
          printf("%-30s", attrib)
        end
      end
    end
    puts

    result_array.each do |result|
      respond_to_ary.each do |attrib|
        # print "  #{result.send(attrib)}"
        case attrib
        when :id, :project_id, :employee_id, :priority
          printf("%-12s", result.send(attrib))
        when :name, :email
          printf("%-20s", result.send(attrib))
        when :completed
          printf("%-12s", result.send(attrib))
        else
          printf("%-30s", result.send(attrib))
        end
      end
      puts
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
