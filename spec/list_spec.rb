require 'spec_helper'

describe "project_list" do
  before do
    @new_project_list = TM::ProjectList.new
    @new_project = TM::Project.new('projname')
  end

  describe "list projects" do
    it "list projects in projects_list array" do
      expect(STDOUT).to receive(:puts).with('proj1')
      expect(STDOUT).to receive(:puts).with('proj2')
      expect(STDOUT).to receive(:puts).with('proj3')
      @new_project_list.add_project('proj1')
      @new_project_list.add_project('proj2')
      @new_project_list.add_project('proj3')

      @new_project_list.list_projects
    end
  end

  describe "add project" do
    it "adds a project" do
      @new_project_list.add_project('projname')
      result = @new_project_list.project_list
      expect(result[0].name).to eq ('projname')
    end
  end

end
