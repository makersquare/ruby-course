require 'spec_helper'

describe "project_list" do
  before do
    @new_project_list = TM::ProjectList.new
    @new_project = TM::Project.new('projname')
  end
  describe "add project" do
    it "adds a project" do
      @new_project_list.add_project(@new_project)
      result = @project_list.project_list
      expect(result[0]).to eq (@new_project)
    end
  end
end
