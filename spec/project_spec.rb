require 'spec_helper'
require 'pry'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  context 'a project is initalized' do
    let(:project) { TM::Project.new("My_first_project") }

    it 'initializes with a name' do
        expect(project.name).to eq("My_first_project")
    end

     it 'creates a unique ID' do
      expect(project.id).to eq(2)
    end

  end

  context 'a project can see task' do
    it 'can see a list of task by creation date' do
    end

    it 'can retrieve a list of incompleted task sorted by priority' do
    end
  end

  context 'a task has the same priority number as another task' do
    it 'gives the older project precedence' do
    end
  end
end
