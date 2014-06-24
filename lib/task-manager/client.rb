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
      '  create tasks PID PRIORITY DESC - Add a new task to project PID',
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
    name = args.join(' ')

    results = TM.db.create(sklass, {'name' => name})
    display(sklass, results)
  end

  def self.create_projects(sklass, args = [])
    name = args.join(' ')

    results = TM.db.create(sklass, {'name' => name})
    display(sklass, results)
  end

  def self.create_tasks(sklass, args = [])
    project_id  = args.shift
    priority    = args.shift
    description = args.join(' ')

    tasks  = TM.db.create(sklass, {'priority' => priority, 'description' => description})
    task_id = tasks.first[:id]
    ptasks = TM.db.create('projecttasks', {'project_id' => project_id, 'task_id' => task_id})
    display(sklass, tasks)
  end

  def self.show_employees(sklass, args = [])
    employee_id = args.shift
    type        = args.shift

    if employee_id.nil?
      results = TM.db.find(sklass, {})
      display(sklass, results)
    else
      results = TM.db.find(sklass, {'id' => employee_id})
      display(sklass, results)

      type = type.upcase if type

      case type
      when 'COMPLETED'
        # results = TM.db.find_employee_tasks('tasks', {'employee_id' => employee_id, 'completed' => true})
        results = TM.db.find('tasks, employeetasks', {'employee_id' => employee_id, 'completed' => true})

        display('tasks', results)
      when 'INCOMPLETE'
        results = TM.db.find('tasks, employeetasks', {'employee_id' => employee_id, 'completed' => false})
        display('tasks', results)
      else
        # project_id = employees.first.send(:project_id)
        results = TM.db.find('projects, employeeprojects', {'employee_id' => employee_id})
        display('projects', results)
      end
    end
  end

  def self.show_projects(sklass, args = [])
    project_id = args.shift
    type       = args.shift

    if project_id.nil?
      results = TM.db.find(sklass, {})
      display(sklass, results)
    else
      results = TM.db.find(sklass, {'id' => project_id})
      display(sklass, results)

      type = type.upcase if type

      case type
      when 'COMPLETED'
        # results = TM.db.find('tasks', {'project_id' => project_id, 'completed' => true})
        results = TM.db.find('tasks, projecttasks', {'project_id' => project_id, 'completed' => true})
        display('tasks', results)
      when 'EMPLOYEES'
        # results = TM.db.find('employees', {'project_id' => project_id})
        results = TM.db.find('employees, employeeprojects', {'project_id' => project_id})
        display('employees', results)
      else
        # results = TM.db.find('tasks', {'project_id' => project_id, 'completed' => false})
        results = TM.db.find('tasks, projecttasks', {'project_id' => project_id, 'completed' => false})
        display('tasks', results)
      end
    end
  end

  def self.show_tasks(sklass, args = [])
    task_id = args.shift

    results = TM.db.find(sklass, {'id' => task_id})
    display(sklass, results)
  end

  def self.recruit_projects(sklass, args = [])
    project_id  = args.shift
    employee_id = args.shift

    results = TM.db.create('employeeprojects', {'project_id' => project_id, 'employee_id' => employee_id})

    # employee = TM.db.update('employees', employee_id, {'project_id' => project_id})

    self.show_projects('projects', [project_id, 'EMPLOYEES'])
  end

  # assign tasks TID EID - Assign task TID to employee EID
  def self.assign_tasks(sklass, args = [])
    task_id     = args.shift
    employee_id = args.shift

    # tasks    = TM.db.find(sklass, {'id' => task_id})
    # employee = TM.db.find('employees', {'id' => employee_id}).first

    results = TM.db.find('employeeprojects', {'employee_id' => employee_id})

    if results.empty?
      display_error "Employee #{employee_id} is not assigned to the project for task #{task_id}"
    else
      self.show_employees('employees', [employee_id, 'INCOMPLETE'])
    end

    # if employee.project_id == task.project_id
    #   results = TM.db.update(sklass, task_id, {'employee_id' => employee_id})
    #   display(sklass, results)
    # else
    #   display_error "Employee #{employee_id} is not assigned to project #{task.project_id}"
    # end
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
      display(sklass, results)
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
      display(sklass, results)
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
      display(sklass, results)
    end
  end

  def self.display_error(error)
    puts error
  end

  def self.display(sklass, result_array)
    puts sklass.upcase
    result_array.first.keys.each do |key|
      case key
      when :id, :project_id, :employee_id, :priority
        printf("%-12s", key.upcase)
      when :name, :email
        printf("%-20s", key.upcase)
      when :completed
        printf("%-12s", key.upcase)
      else
        printf("%-30s", key.upcase)
      end
    end
    puts

    result_array.each do |key, value|
      case key
      when :id, :project_id, :employee_id, :priority
        printf("%-12s", value)
      when :name, :email
        printf("%-20s", value)
      when :completed
        printf("%-12s", value)
      else
        printf("%-30s", value)
      end
      puts
    end
  end


  # def self.display(sklass, result_array)
  #   puts sklass.upcase
  #   respond_to_ary = []
  #   [:id, :name, :email, :description, :project_id,
  #    :employee_id, :priority, :completed, :created_at].each do |attrib|
  #     if result_array.first.respond_to?(attrib)
  #       respond_to_ary.push(attrib)
  #       # print "  #{attrib}"
  #       case attrib
  #       when :id, :project_id, :employee_id, :priority
  #         printf("%-12s", attrib.upcase)
  #       when :name, :email
  #         printf("%-20s", attrib.upcase)
  #       when :completed
  #         printf("%-12s", attrib.upcase)
  #       else
  #         printf("%-30s", attrib.upcase)
  #       end
  #     end
  #   end
  #   puts

  #   result_array.each do |result|
  #     respond_to_ary.each do |attrib|
  #       # print "  #{result.send(attrib)}"
  #       case attrib
  #       when :id, :project_id, :employee_id, :priority
  #         printf("%-12s", result.send(attrib))
  #       when :name, :email
  #         printf("%-20s", result.send(attrib))
  #       when :completed
  #         printf("%-12s", result.send(attrib))
  #       else
  #         printf("%-30s", result.send(attrib))
  #       end
  #     end
  #     puts
  #   end
  # end

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
