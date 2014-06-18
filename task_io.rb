require_relative 'lib/task-manager.rb'
#require 'io/console'

class Task_io
    puts "Welcome to Task Manager.  How may we assist you?\n\n"

    puts "Available Commands: \n"
    puts "  help - Show these commands again"
    puts "  create NAME - Create a new project with name=NAME"
    puts "  show PID - Show remaining tasks for a project with id=PID"
    puts "  history PID - Show completed tasks for project with id=PID"
    puts "  add PID PRIORITY DESC - Add a new task to project with id=PID"
    puts "  mark PID TID - Mark task with id=TID assigned to project with id=PID as complete"
    puts "  get PID - Get a list of all tasks per project with project id=PID"
    puts "  list - Get a list of projects and their ids"
    puts "  quit - Exit program\n"

    @@io_projects = []
    @@io_tasks = []

  def start

    puts 'Enter request>'
    req = gets.chomp
    command = req.split[0]
    input = req.split

    if req == 'quit'
        return
    else
        case command
            when 'help'
                puts "Available Commands: \n"
                puts "  help - Show these commands again"
                puts "  create NAME - Create a new project with name=NAME"
                puts "  show PID - Show remaining tasks for a project with id=PID"
                puts "  history PID - Show completed tasks for project with id=PID"
                puts "  add PID PRIORITY DESC - Add a new task to project with id=PID"
                puts "  mark PID TID - Mark task with id=TID assigned to project with id=PID as complete"
                puts "  get PID - Get a list of all tasks per project with project id=PID"
                puts "  list - Get a list of projects and their ids"
                puts "  quit - Exit program\n"
                self.start
            when 'create'
                proj = TM::Project.new(input[1])
                puts "#{proj.name} was created with ID=#{proj.pid}"
                @@io_projects << proj
                self.start
            when 'show'
                proj_id = input[1].to_i
                puts @@io_projects[proj_id].list_incomplete_tasks
                self.start
            when 'history'
                proj_id = input[1].to_i
                puts @@io_projects[proj_id].list_completed_tasks
                self.start
            when 'add'
                i = 0
                proj_id = input[1].to_i
                task = @@io_projects[proj_id].add_task(input[2], input[3].to_s)
                puts "#{input[3].to_s} was assigned TID #{@@io_tasks.size}"
                @@io_tasks << task
                i += 1
                self.start
            when 'list'
                @@io_projects.each { |i| puts "PID #{i.pid}: #{i.name}"}
                self.start
            when 'get'
                proj_id = input[1].to_i
                puts @@io_projects[proj_id].list_all_tasks
                self.start
            when 'mark'
                proj_id = input[1].to_i
                task_id = input[2].to_i
                @@io_projects[proj_id].tasks[task_id].mark_complete
                puts "Project #{input[1]}, task TID #{input[2]} is complete"
                self.start
            else
                puts "Invalid request, please try again"
                self.start
            end
        end
    end
end

Task_io.new.start
