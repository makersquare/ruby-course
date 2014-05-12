require 'spec_helper'
require 'pry'

describe 'Project' do

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  context 'a project is initalized' do
    let(:project) { TM::Project.new({ name: "My_first_project", id: 1, completed: false } )}

    it 'initializes with a name' do
        expect(project.name).to eq("My_first_project")
    end

    it 'initializes with a uniquie id' do
      expect(project.id).to eq(1)
    end

    it 'initalizes wiht a completed status of fasle' do
      expect(project.completed?).to eq(false)
    end

  end

  context 'a project can be updated' do
    before(:each) do
      @db = TM.db
      @db.create_project({ :name => "Pizza Party Planning" })
      @new_project = @db.get_project(1)
    end

    it 'can make a project as complete' do
      @new_project.complete_project
      expect(@db.get_project(1).completed?).to eq(true)
    end

    it 'can delete a project' do
      @new_project.destroy
      expect(@db.projects.count).to eq(0)
    end
  end

  context 'a project is created and task are assigned to it' do
    before(:each) do
      @db = TM.db
      @db.create_project({ :name => "Pizza Party Planning" })
      @new_project = @db.get_project(1)
      @db.create_task({description: "Second Task", priority: 2, pid: 1})
      @db.create_task({description: "First Task", priority: 1, pid: 1})
    end

    it 'can can get a list of incomplete task' do
      expect(@new_project.incomplete_task.length).to eq(2)
      # binding.pry
    end

    it 'can can list incomplete task by priority' do
      expect(@new_project.incomplete_task.first[:priority]).to eq(2)
    end

    it 'can show a list of completed task' do
      TM.db.get_task(2).complete_task
      # binding.pry
      expect(@new_project.completed_task.first[:description]).to eq("First Task")
    end
  end
end
