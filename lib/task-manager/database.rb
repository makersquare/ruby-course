module TM
  class DB

    attr_reader :all_tasks, :all_proj, :all_emp

    def initialize
      # {task_id => task_obj}
      @all_tasks = {}
      # {proj_id => proj_obj}
      @all_proj = {}
      # {emp_id => emp_obj}
      @all_emp = {}
    end

    # TASK FUNCTIONALITY
    def create_task(projID, description, priority)
      new_task = Task.new(projID, description, priority)
      @all_tasks[new_task.id] = new_task
      new_task
    end

    def get_task(tid)
      @all_tasks[tid]
    end

    def get_inc_emp_tasks(eid)
      task_arr = []
      task_hash = {}
      @all_tasks.each do |tid, task|
        if (task.eid == eid && !task.complete)
          task_arr << task
        end
      end

      task_arr.each do |task|
          if @all_proj[task.projID]
            # task_hash = {task_id => [task, project]}
            task_hash[task.id] = [task, @all_proj[task.projID]]
          end
      end

      task_hash
    end

    def get_comp_emp_tasks(eid)
      task_arr = []
      task_hash = {}
        @all_tasks.each do |tid, task|
          if (task.eid == eid && task.complete)
            task_arr << task
          end
        end

        task_arr.each do |task|
          if @all_proj[task.projID]
            # task_hash = {task_id => [task, project]}
            task_hash[task.id] = [task, @all_proj[task.projID]]
          end
        end

      task_hash
    end

# Returns nil if you attempt to assign an employee
# to a task belonging to a project to which they
# are not assigned
    def update_task(tid, data_hash)
      if @all_tasks[tid]
        if data_hash[:complete]
          @all_tasks[tid].complete = data_hash[:complete]
        end
        if data_hash[:description]
          @all_tasks[tid].description = data_hash[:description]
        end
        if data_hash[:priority]
          @all_tasks[tid].priority = data_hash[:priority]
        end
        if data_hash[:eid]
          proj = @all_proj[@all_tasks[tid].projID]
          if proj.emp_ids[data_hash[:eid]]
            @all_tasks[tid].eid = data_hash[:eid]
          else
            return nil
          end
        end
      end
      @all_tasks[tid]
    end

    def delete_task(tid)
      @all_tasks.delete(tid)
    end
    # END OF TASK FUNCTIONALITY


    # PROJECT FUNCTIONALITY

    def create_project(name)
      new_proj = Project.new(name)
      @all_proj[new_proj.id] = new_proj
      new_proj
    end

    def get_project(pid)
      @all_proj[pid]
    end

    def update_project(pid, data_hash)
        if @all_proj[pid]
          if data_hash[:name]
            @all_proj[pid].name = data_hash[:name]
          end
          if data_hash[:eid]
            @all_proj[pid].add_emp(data_hash[:eid])
          end
        end
        @all_proj[pid]
    end

    def delete_project(pid)
      @all_proj.delete(pid)
    end

    def get_all_tasks(pid) #returns an array of all tasks for a project
      task_arr = []
      @all_tasks.each do |tid, task|
        if task.projID == pid
          task_arr << task
        end
      end
      task_arr
    end

    def get_all_proj
      proj_arr = []
      @all_proj.each do |pid, proj|
        proj_arr << proj
      end
      proj_arr
    end

    def get_proj_emps(pid)
      proj = self.get_project(pid)
      emp_hash = proj.emp_ids
      ret_arr = []

      emp_hash.each do |k, v|
        ret_arr << @all_emp[k]
      end
      ret_arr
    end

    def sort_comp_tasks(pid) #Returns an array of completed tasks sorted by creation date
      comp_tasks = []

      @all_tasks.each do |tid, task|
        if task.projID == pid
          if task.complete
            comp_tasks << task
          end
        end
      end

      if comp_tasks.length != 0
        comp_tasks.sort{|task1, task2| task1.created <=> task2.created}
      else
        [] # "There are no completed tasks in this project."
      end
    end

    def sort_inc_tasks(pid) #returns array of inc tasks sorted by priority then creation date
      inc_tasks = []

      @all_tasks.each do |tid, task|
        if task.projID == pid
          if !task.complete
            inc_tasks << task
          end
        end
      end

      if inc_tasks.length != 0
        inc_tasks.sort{|task1, task2|
        if task1.priority == task2.priority
          task1.created <=> task2.created
        else
          task1.priority <=> task2.priority
        end
        }
      else
        [] # There are no incomplete tasks in this project.
      end
    end

    def hi_prio(pid) # returns high priority incomplete tasks
      inc_tsk_arr = self.sort_inc_tasks(pid)
      counter = 0
      hi_prio_arr = []

        if inc_tsk_arr.length != 0
          inc_tsk_arr.each do |task|
            if task.priority <= 2
              hi_prio_arr << task
            end
          end
        end

        hi_prio_arr
    end
    # END OF PROJECT FUNCTIONALITY

    # EMPLOYEE FUNCTIONALITY

    def create_emp(name)
      new_emp = Employee.new(name)
      @all_emp[new_emp.id] = new_emp
      new_emp
    end

    def get_emp(eid)
      @all_emp[eid]
    end

    def get_emp_proj(eid)
      proj_arr = []
      @all_proj.each do |pid, proj|
        if proj.emp_ids[eid]
          proj_arr << proj
        end
      end
      proj_arr
    end

    def update_emp(eid, name)
      if @all_emp[eid]
          @all_emp[eid].name = name
      end
        @all_emp[eid]
    end

    def delete_emp(eid)
      @all_emp.delete(eid)
    end

  end # END OF DB CLASS


  def self.db
    @__db_instance ||= DB.new
  end

end
