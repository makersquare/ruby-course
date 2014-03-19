module TM
  class Project_list
    @@proj_ls = []

    def initialize
    end

    def create_project(name)
      proj = Project.new(name)
      @@proj_ls << proj
    end

    def ls_proj
      @@proj_ls
    end

    def get_project(project_id)
      @@proj_ls.each do |project|
        if project.id == project_id
          project
        else
          "No such project exists"
        end
      end
    end

    def show_all(project_id)

    end

    def view_tasks(project_id)
      view_proj = self.get_project(project_id)
      view_proj.all_tasks
    end

  end
end

# client.rb opens a new project and immediately provides a
# command list

# For Project_list:
