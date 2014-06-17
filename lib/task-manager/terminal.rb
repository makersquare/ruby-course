# require 'pry-byebug'

class TM::Terminal
    attr_accessor :add

    def print_menu
        puts "Welcome to Task Manager 5000. An app to handle all your organization needs!"
        puts "Here is a list of available commands: "
        puts "help- Show the list of commands again"
        puts "list- List all projects"
        puts "create NAME- Creates a new project with name=NAME"
        puts "show PID- Show remaining tasks for project with id=PID"
        puts "history PID- Show completed tasks for project with id=PID"
        puts "add PID PRIORITY DESC - Add a new task and it's priority and description to project with id=PID"
        puts "mark TID - Mark task with id=TID as complete"
        run
    end

    def run
        puts "::::>"
        user_input = gets.chomp
        split_it = user_input.split
        cmd = split_it.first
        parse(cmd, split_it)
    end

    def parse(cmd, split_it)
        case cmd
        when 'add'
            add_task(split_it[1].to_i, split_it[2].to_i, split_it[3..-1].join(" "))
        when 'help'
            print_menu
        when 'list'
           TM::Project.project_list
        when 'create'
            create(split_it[1])
        when 'show'
            show_remaining(split_it[1].to_i)
        when 'history'
            show_complete(split_it[1].to_i)
        when 'mark'
            mark_complete(split_it[1].to_i)
        when 'exit'
            return "Goodbye"
        end
        run
    end

    def add_task priority, pid, description
        puts "You just added #{description} with a priority of #{priority} to project #{pid}"
        TM::Task.new(priority, pid, description)
    end

    def create name
        puts "You created a new project called: #{name}"
        TM::Project.new(name)
    end

    def show_remaining pid
        TM::Project.get_incomplete_tasks(pid)
    end

    def show_complete pid
        TM::Project.get_complete_tasks(pid)
    end

    def mark_complete tid
        TM::Task.mark_complete(tid)
    end
end
