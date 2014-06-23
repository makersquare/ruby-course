
class TM::Task
	@@task_counter = 0
	@@list_task = []
	attr_reader :p_id, :desc, :priority, :state_complete, :creation_date, :id
	def initialize(p_id=nil,desc=nil,priority=nil)
		@p_id=p_id.to_i
		@desc=desc
		@priority=priority
		@state_complete = false
		@creation_date = Time.now
		@@task_counter +=1
		@id = nil
		@@list_task << self
		# @@list_task.each {|t| puts " task id: #{t.p_id} priority: 
		#{t.priority} D: #{t.desc}" }
		return self
	end

	def state_complete!
		@state_complete = true
	end

	def save!(id)
		@id = id if @id.nil?
		
	end

	def self.list_task
		@@list_task
	end

	def self.complete_a_task(id)
		@@list_task[id - 1].state_complete!
	end

end


