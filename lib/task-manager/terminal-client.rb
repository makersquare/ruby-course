class TM::TerminalClient
	
	def initialize 
		puts 'Welcome to Project Manager Pro®. What can I do for you today?

Available Commands:
  help - Show these commands again
  list - List all projects
  create NAME - Create a new project with name=NAME
  show PID - Show remaining tasks for project with id=PID
  history PID - Show completed tasks for project with id=PID
  add PID PRIORITY DESC - Add a new task to project with id=PID
  mark TID - Mark task with id=TID as complete'
		
	end
end