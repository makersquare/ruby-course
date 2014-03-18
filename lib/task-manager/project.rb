
class TM::Project
	attr_reader :name, :id
	def initialize (name)
		@name = name
		@@id = (0...8).map { (65 + rand(26)).chr }.join
		@comptasks = []
	end

	def self.id 
		@@id 
	end

	def completed_tasks (task)
		
		if task.task_completion[1] == 'yes'
			@comptasks.push(task.task_completion)
		end
		@comptasks.sort{|x| x[2]}

		
	end
end
