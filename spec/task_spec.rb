require 'spec_helper'

describe 'Task' do
  before(:each) do
    @db = TM.db
    allow(Time).to receive(:now).and_return(Time.parse("8am"))
    @db.create_task({description: "New Task", priority: 1, pid: 1})
    @db.create_task({description: "Second Task", priority: 2, pid: 1})
    @db.create_employee(name: "Jason")
    @task = @db.get_task(1)
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  context 'a new task is initialized' do
    it 'creates a new task with a description' do
      expect(@task.description).to eq("New Task")
    end

    it 'creates a new task with a project id' do
      expect(@task.pid).to eq(1)
    end

    it 'creates a new task with a priority' do
      expect(@task.priority).to eq(1)
    end

    it 'has an initial status of complete' do
      expect(@task.complete?).to eq(false)
    end

    it 'has a unique id' do
      expect(@db.get_task(2).id).to eq(2)
    end

    it 'creates a new task with the time of now' do
      expect(@task.creation_date).to eq(Time.parse("8am"))
    end

    it 'can destroy a task' do
      @db.get_task(1).destroy
      expect(@db.task.count).to eq(1)
    end

    it 'can assign and remove an employee' do
      @db.create_project(name: "New Project")

      @task.assign_employee(1)
      expect(@db.get_task(1).eid).to eq(false)

      @db.get_employee(1).assign_project(1)
      @task.assign_employee(1)
      expect(@db.get_task(1).eid).to eq(1)

      @db.get_task(1).remove_employee
      expect(@db.get_task(1).eid).to eq(false)
    end
  end
end
