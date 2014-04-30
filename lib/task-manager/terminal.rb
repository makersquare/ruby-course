class TM::Terminal

  attr_accessor :choice

  def initialize
    puts "Welcome to Project Manager Pro®. What can I do for you today?"
    puts "Available Commands:
              help - Show these commands again
              list - List all projects
              create - Create a new project with name=NAME
              show PID - Show remaining tasks for project with id=PID
              history PID - Show completed tasks for project with id=PID
              add PID PRIORITY DESC - Add a new task to project with id=PID
              mark TID - Mark task with id=TID as complete"
    @choice = gets.chomp.downcase
    menu(@choice)
  end

  def menu(choice)
    case choice
      when 'help'
        puts "Available Commands:
                help - Show these commands again
                list - List all projects
                create - Create a new project with name=NAME
                show PID - Show remaining tasks for project with id=PID
                history PID - Show completed tasks for project with id=PID
                add PID PRIORITY DESC - Add a new task to project with id=PID
                mark TID - Mark task with id=TID as complete"
        puts "Please input what you would like to do from the list above:"
        @choice = gets.chomp.downcase
        menu(@choice)
      when 'list'
        TM::Project.projects.each {|x| puts x.name}
      when 'create'
        puts "What would you like to name the new project?"
        title = gets.chomp
        title = TM::Project.new(title)
        puts "Congratulations! #{title.name} project has been created."
      when 'show'
        puts "What project would you like to see the remaining tasks for?"
        project1 = gets.chomp
        for i in 0...TM::Project.projects.length
          if TM::Project.projects[i].name == project1
            TM::Project.projects[i].incomplete_tasks()
          end
          puts TM::Project.projects[i].incomplete_tasks().each {|x| puts x.project_id}
        end
      else
        puts "Rock on King Kong"
      end
  end
end

