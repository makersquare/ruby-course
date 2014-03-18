require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe '.initialize' do
    it 'creates a new project with a name' do
      new_project = TM::Project.new('project name')
      result = new_project.project_name
      expect(result).to eq('project name')
    end
    it 'assigns each project a unique_id' do
      new_project = TM::Project.new('project name')
      result = new_project.id_counter
      expect(result).to eq(2)
    end
  end

end
