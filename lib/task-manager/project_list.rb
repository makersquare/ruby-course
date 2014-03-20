

class TM::ProjectList
	attr_accessor :project_list, :narrowed_again, :narrowed_again1
	def initialize
	@project_list = []
	end

	def add_project (project)
	@project_list.push(project)

	end


	def tasks_for_project (id)
		narrowed_down = @project_list.find{|x| x.id == id.to_i}
		@narrowed_again = narrowed_down.incompleted_tasks_list
		 
		
	end

	def tasks_for_project_complete(id)
		narrowed_down = @project_list.find{|x| x.id == id.to_i}
		@narrowed_again1 = narrowed_down.completed_tasks_list
	end

  def mark_task_complete (id)
    @project_list.each do |proj|
      task = proj.incompleted_tasks_list.find {|y| y.tid == id.to_i }
      if task
        task.complete_task
      end
    end
  end


end