require 'spec_helper'

describe 'Task' do
  before(:each) do
    @db = TM.db
    allow(Time).to receive(:now).and_return(Time.parse("8am"))
    @db.create_task({description: "New Task", priority: 1, pid: 1})
    @db.create_task({description: "Second Task", priority: 2, pid: 1})
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

    it 'has a uniquer id' do
      expect(@db.get_task(2).id).to eq(2)
    end

    it 'creates a new task with the time of now' do
      expect(@task.creation_date).to eq(Time.parse("8am"))
    end

  end

end
