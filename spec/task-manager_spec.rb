require 'spec_helper'
require 'pry'

describe "TaskManager::Database" do

  before(:each) do
    @db = TM.db
  end

  it 'exist' do
    expect(TM::Database).to be_a(Class)
  end

  context 'it is initialized' do

    it 'creates an empty projects hash' do
      expect(@db.projects).to eq({})
    end

    it 'creates an empty task hash' do
      expect(@db.task).to eq({})
    end

    it 'has a projects counter' do
      expect(@db.projects_counter).to eq(0)
    end

    it 'has a task counter' do
      expect(@db.task_counter).to eq(0)
    end

  end

  context 'a new project is added to the datebase' do
    before(:each) do
      @new_project = @db.create_project({ :name => "Pizza Party Planning" })
    end

    it 'can add new projects' do
      expect(@db.projects).to eq({ 1 => { name: "Pizza Party Planning", id: 1, completed: false } })
      expect(@db.projects_counter).to eq(1)
    end

    it 'can return a project' do
      expect(@db.get_project(1).name).to eq("Pizza Party Planning")
    end

    it 'can update a project' do
      @db.update_project(1, { name: "Pizza and Ice Cream Party Planning" } )
      expect(@db.projects[1][:name]).to eq("Pizza and Ice Cream Party Planning")
    end

    it 'can destroy a project' do
      @db.destroy_project(1)
      expect(@db.projects).to eq({})
    end

    it 'can build a new project' do
      expect(@db.build_project({ :name => "Pizza Party Planning", id: 1, completed: false }).id).to eq(1)
    end

  end


  context 'a task is created' do

    before(:each) do
      @new_project = @db.create_project({ :name => "Pizza Party Planning" })
      @new_task = @db.create_task({ description: "Find Pizza", pid: 1, priority: 1 })
    end

    it 'can add new task' do
      expect(@db.task.count).to eq(1)
    end

    it 'increases the task counter' do
      expect(@db.task_counter).to eq(1)
    end

    it 'can retrieve a task by its id' do
      expect(@db.get_task(1).description).to eq("Find Pizza")
    end

    it 'can update a tasks information' do
      @db.update_task(1, {description: "Find some ice cream"})
      expect(@db.task[1][:description]).to eq("Find some ice cream")
    end

    it 'can destroy a task' do
      @db.destroy_task(1)
      expect(@db.task[1]).to eq(nil)
    end

  end

end
