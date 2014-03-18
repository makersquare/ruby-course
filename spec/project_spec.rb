require 'spec_helper'

describe 'Project' do

  describe '.initialize' do
    it 'assigns a name to new project' do
      new_project = TM::Project.new('projname')
      result = new_project.name
      expect(result).to eq 'projname'
    end

    it "automatically assigns a new unique id" do
      new_project = TM::Project.new('projname')
      result = new_project.id_counter
      expect(result).to eq 2
    end
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

end
