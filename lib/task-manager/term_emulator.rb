class TM::Terminal
  @@display_project = Proc.new { |project| puts "#{project.id.ljust(8)} - #{project.name}" }
  @@project_title = @@display_project.call(TM::Project.new("NAME","ID"))

  @@display_task = Proc.new { |task| puts "#{task.id.ljust(6)} - #{task.pid.ljust(4)}  #{task.priority.ljust(2)}  #{task.detail.ljust(45)}  #{task.complete.ljust(6)}  #{task.created.ljust(16)}" }
  @@task_title = @@display_task.call(TM::Task.new("PID","DESCRIPTION","PRIORITY","COMPLETE","ID","CREATED"))

  def self.call()
    puts "Welcome to Project Manager Pro. What can I do for you?"
    show_help
    get_input
  end

  def self.get_input
    print " >"
    input = gets.chomp
    input = input.split()
    parse_input(input.shift, input)
  end

  def self.parse_input(cmd, args)
    case cmd
    when "add"
      invalid_input(cmd, args) unless add_task(args)
    when "create"
      invalid_input(cmd, args) unless create_project(args)
    when "mark"
       invalid_input(cmd, args) unless mark_task(args)
    when "history"
      invalid_input(cmd, args) unless show_history(args)
    when "show"
      invalid_input(cmd, args) unless show_tasks(args)
    when "list"
      list_projects
    when "help"
      show_help
    when "clear"
      system "clear" or system "cls"
    when "exit"
      return
    else
      puts "Invalid command #{cmd}. Type <help> to show available commands."
    end

    get_input
  end

  def self.create_project(name)
    return false unless name
    project = TM::Project.new(name)
    project.save!
    true
  end

  def self.add_task(args)
    pid, detail, priority = args
    return false unless pid && detail
    task = TM::Task.new(pid,detail,priority)
    task.save!
    true
  end

  def self.mark_task(id)
    return false unless id
    task = TM.db.get_tasks({"id"=>id}).first
    task.complete!
    true
  end

  def self.list_projects
    projects = TM.db.get_projects
    puts @@project_title
    projects.each(&@@display_project)
  end

  def self.show_tasks(pid)
    project = TM.db.get_projects({"id"=>pid}).first
    puts "Project #{project[:id]} - #{project[:name].upcase} -- "
    puts @@task_title
    project.get_incomplete_tasks.each(&@@display_task)
  end

  def self.show_history(pid)
    project = TM.db.get_projects({"id"=>pid}).first
    puts "Project #{project[:id]} - #{project[:name].upcase} -- "
    puts @@task_title
    project.get_complete_tasks.each(&@@display_task.call)
  end

  def self.show_help
    command_list = {
      :list    => [[]     , "List all projects"],
      :create  => [[:name], "Create a new project with name=NAME"],
      :add     => [[:pid, :priority, :detail ], "Add a new task to project with id=PID"],
      :show    => [[:pid] , "Show remaining tasks for project with id=PID"],
      :history => [[:pid] , "Show completed tasks for project with id=PID"],
      :mark    => [[:tid] , "Mark task with id=TID as complete"],
      :help    => [[]     , "Display this menu"],
      :clear   => [[]     , "Clear the screen"],
      :exit    => [[]     , "Exit the program"],
    }

    system "clear" or system "cls"
    puts "-- Project Manager Pro --\n"
    puts "Available Commands:\n\n"
    command_list.each {|k,v| puts "#{k}   #{v[0].map {|x| x.upcase }.join(' ').ljust(22-k.length)}  -   #{v[1]}"}
    puts
  end


  def self.invalid_input(input)
    puts "ERROR: Invalid parameter(s) for command #{input[0]}"
    puts "-- #{input[1..-1].join(" ")} -- not recognized."
    puts "type 'help' at any time to display the help menu"
    get_input
  end
end
