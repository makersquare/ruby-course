module TM
  class ProjectList
    @@proj_ls = []

    def initialize
    end

    def create_project(name)
      proj = Project.new(name)
      @@proj_ls << proj
      proj
    end

    def get_project(project_id)
      @@proj_ls.each do |project|
        if project.id == project_id
          return project
        end
      end
      return "No such project exists"
    end

    def show_all
      @@proj_ls
    end

    def view_all_tasks(project_id)
      view_proj = self.get_project(project_id)
      view_proj.all_tasks
    end

    def show_inc(project_id)
      a_project = self.get_project(project_id)
      a_project.sort_inc
    end

    def show_comp(project_id)
      my_project = self.get_project(project_id)
      my_project.sort_comp
    end

    def add_new_task(project_id, description, priority)
      my_proj = self.get_project(project_id)
      my_proj.add_task(description, priority)
    end

    def mark_task_c(task_id)
      # iterate over each project in the project list
      # from each project, pull the sorted list of incomplete
      # tasks

      # inc_hash = {}
      @@proj_ls.each do |project|
        inc_arr = project.sort_inc
        if inc_arr.class != String
          inc_hash = Hash[inc_arr]
            if inc_hash[task_id]
              task_c = project.mark_complete(task_id)
              return task_c
            end
        end
      end

      return "No such task exists/task is already complete"
  end

# iterate through their incomplete tasks
# ++ a counter variable each time a task has priority
# 4 or more MOVED TO PROJECT.RB

  # def hi_prio(project_id)
  #   a_proj = self.get_project(project_id)
  #   incom_arr = a_proj.sort_inc
  #   counter = 0

  #     if incom_arr.length != 0
  #       incom_arr.each do |task_arr|
  #         if task_arr[1].priority >= 4
  #           counter +=1
  #         end
  #       end
  #     end

  #   return counter
  # end

  end
end

# client.rb opens a new project and immediately provides a
# command list

# For Project_list:
