require 'spec_helper'

describe 'ProjectList' do
  before do
    @pl = TM::ProjectList.new
  end
  describe '.initialize' do
    it "defaults the Project List with an empty projects array" do
      expect(@pl.projects).to eq([])
    end
  end

  it "can create a project and add it to the projects array" do

    @pl.create_project("The Best Project")
    projects_array = @pl.projects

    expect(projects_array.size).to eq(1)
    expect(projects_array.first).to be_a(TM::Project)
  end
end