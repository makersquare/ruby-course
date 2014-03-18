require 'spec_helper'

describe 'Project' do
  before do
    @new_project = TM::Project.new('project name')
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe '.initialize' do
    it 'creates a new project with a name' do
      result = @new_project.project_name
      expect(result).to eq('project name')
    end
    it 'assigns each project a unique_id' do
      result = @new_project.project_id
      expect(result).to eq(3)
    end
  end

end
