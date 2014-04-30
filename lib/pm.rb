require_relative 'task-manager.rb'

class TerminalClient
	def self.start
		print_welcome_message
		list_commands
		input = ""
		while input != "exit" do
			print ">> "
			input = gets.chomp
		end
		# puts "Welcome to Project Manager Pro®. What can I do for you today?"
	end

	# private
	def self.print_welcome_message
		puts "Welcome to Project Manager Pro®. What can I do for you today?\n\n"
	end

	# private
	def self.list_commands
		puts "Available Commands:"
		puts "   help            Show these commands again"
		puts "   list            List all projects"
		puts "   create NAME     Create a new project with name=NAME"
		puts "   show PID        Show remaining tasks for project with id=PID"
		puts "   history PID     Show completed tasks for project with id=PID"
		puts "   add PID PRIORITY DESC - Add a new task to project with id=PID"
		puts "   mark TID        Mark task with id=TID as complete"
		puts "   exit            quits application"
	end
end

# project1 = TM::Project.new("project1")

# puts project1.name

TerminalClient.start