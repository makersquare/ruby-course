require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  before do
    @new_project = TM::Project.new('projname')
  end

  describe '.initialize' do
    it 'assigns a name to new project' do
      result = @new_project.name
      expect(result).to eq 'projname'
    end

    it "automatically assigns a new unique id" do
      result = @new_project.project_id
      expect(result).to eq 3
    end


  end


end
