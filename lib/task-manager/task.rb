
class TM::Task
	@@list_task = []
	attr_reader :p_id, :desc, :priority, :state_complete, :creation_date
	def initialize(p_id=nil,desc=nil,priority=nil)
		@p_id=p_id
		@desc=desc
		@priority=priority
		@state_complete = false
		@creation_date = Time.now
		@@list_task << self
	end

	def state_complete!
		@state_complete = true
	end

	def self.list_task
		@@list_task
	end

end


