require 'spec_helper'

describe "project_list" do
  before do
    @new_project_list = TM::ProjectList.new
    @new_project = TM::Project.new('project_name')
  end

  describe "add project" do
    it "adds a project" do
      @new_project_list.add_project('project_name')
      result = @new_project_list.project_list
      expect(result[0].name).to eq ('project_name')
    end
  end

   describe "add task to project" do
    it "adds a task to a project" do
      description = "Holla back, gurl"
      priority = 2
      id = 4

      @new_project_list.add_project("Holla back, gurl")
      # new_task = TM::Task.new('description', 2, 1)
      # binding.pry

      @new_project_list.add_task_to_project(description, priority, id)
      result = @new_project_list.project_list[0].tasks

      expect(result[0].description).to eq("Holla back, gurl")
      expect(result[0].priority).to eq(2)
      expect(result[0].id).to eq(1)
    end
  end

end
