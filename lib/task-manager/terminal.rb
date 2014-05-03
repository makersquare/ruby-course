require 'csv'

class TM::TerminalClient

  attr_reader :menu

  def initialize
    @term_width = 78
    populate_env
    @help =
    '
                      WELCOME.. TO.. JURASSIC PARK

      Available Commands:
        list                  List all projects
        create NAME           Create a new project with name=NAME
        add PID PRIORITY      Add a new task to project id=PID
        show PID              Show remaining tasks for project with id=PID
        history PID           Show completed tasks for project with id=PID
        mark TID              Mark task with id=TID as complete
        exit

        WARNING: Whatever you do, don\'t even think about <ACCESS>ing
          the <MAIN> <SECURITY> <GRID> without the password.
          '
    get_input
  end

  def stuff
    # puts __FILE__
    # puts Dir.getwd
    dir = '/lib/task-manager/nedry.html'
    path = File.expand_path $0
    puts path+dir
  end

  def get_input
    puts `head -28 task-manager/util`
    header('')
    puts @help
    while true
      puts ''
      print '>> '
      cmds = parse_cmd(gets.chomp!)
      exec_cmd(cmds)
      update_term_width
    end
  end

  def parse_cmd(input)
    input = input.split(' ')
    cmd = input.shift
    args = input
    return [cmd, args]
  end

  # basically, a router
  def exec_cmd(cmds)
    cmd, args = cmds.shift, cmds.last
    case cmd
    when 'exit' then exit
    when 'list' then list_all_projects
    when 'create' then create(args)
    when 'add' then add(args)
    when 'show' then show(args)
    when 'history' then history(args)
    when 'mark' then mark(args)
    when 'help' then help
    when 'access' then nedry(args)
    else puts "command invalid. 'help' displays the menu."
    end
  end

  def list_all_projects
    header("ID__Project_Name")
    TM::Project.projects.each {|proj| puts proj}
  end


  def create(args)
    name = args.join(' ')
    TM::Project.new(name)
  end

  def show(args)
    pid = args.shift.to_i
    project = TM::Project.find_project_by_id(pid)
    header("Project_#{project.id}_Incomplete_Tasks")
    project.incomplete.each {|t| puts t}
  end

  def history(args)
    pid = args.shift.to_i
    project = TM::Project.find_project_by_id(pid)
    header("Project_#{project.id}_Completed_Tasks")
    project.completed.each {|t| puts t}
  end

  def mark(args)
    tid = args.shift.to_i
    TM::Task.mark_complete(tid)
  end

  def add(args)
    pid = args.shift.to_i
    priority = args.shift.to_i
    desc = args.join(' ')
    task = TM::Task.new(pid, priority, desc)
    puts "New Task #{task.id} created and assigned to Project #{pid}"
    TM::Project.find_project_by_id(pid).add_task(task)
    task
  end

  def help
    puts @help
  end

  def update_term_width
    @term_width = `tput cols`.chomp!.to_i
  end

  def header str
    puts(str + "=" * (@term_width - str.length))
  end

  def nedry args=[]
    if args.join(' ') == 'main security grid'
      puts "access: PERMISSION DENIED....and..."
      6.times do
        puts "YOU DIDN'T SAY THE MAGIC WORD!"
        sleep(0.2)
      end
      `open task-manager/nedry.html`
    else
      puts "access: PERMISSION DENIED"
    end
  end

  def populate_env
    exec_cmd(parse_cmd('create Park Tour'))
    exec_cmd(parse_cmd('add 1 2 Install child-proof locks in Jeeps. (all 4 doors)'))
    exec_cmd(parse_cmd('add 1 3 Check radar for inclement weather!'))
    exec_cmd(parse_cmd('add 1 1 Defrost the Chilean Sea Bass'))
    exec_cmd(parse_cmd('add 1 1 Brush up on Chaos Theory'))
    exec_cmd(parse_cmd('mark 1'))
    exec_cmd(parse_cmd('mark 3'))
    exec_cmd(parse_cmd('mark 4'))
    exec_cmd(parse_cmd('create Animal Care & Maintenance'))
    exec_cmd(parse_cmd('add 2 2 Examine Triceratops droppings for infection'))
    exec_cmd(parse_cmd('add 2 1 Inspect egg incubators'))
    exec_cmd(parse_cmd('add 2 3 Feed the raptors'))
    exec_cmd(parse_cmd('add 2 2 Fix the T-Rex paddock fence'))
    exec_cmd(parse_cmd('mark 6'))
  end
end
