require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  before do
    expect(TM::Project).to receive(:gen_id).and_return(1)
    @new_project = TM::Project.new('projname')
  end

  describe '.initialize' do
    it 'assigns a name to new project' do
      result = @new_project.name
      expect(result).to eq 'projname'
    end

    it "automatically assigns a new unique id" do
      result = @new_project.id
      expect(result).to eq 1
    end
  end

  describe 'add_task' do
    it "adds a task to project" do
      task = TM::Task.new("description", 2)
      @new_project.add_task(task)
      result = @new_project.tasks[0]
      expect(result).to eq task
    end

    it "assigns the correct id to the task" do
      task = TM::Task.new("description")
      @new_project.add_task(task)
      result = task.project_id
      expect(result).to eq 1
    end
  end

  describe 'complete' do
    it 'marks a task complete by id' do
      task = TM::Task.new("description")
      @new_project.add_task(task)
      @new_project.complete(3)
      result = task.complete
      expect(result).to eq true
    end
  end

  describe 'retreive completed tasks, by date' do
    it 'retrieves a list of completed tasks by date' do
      task = TM::Task.new('bla')
      task2 = TM::Task.new('blablabla')
      task3 = TM::Task.new('noshow')
      @new_project.add_task(task)
      @new_project.add_task(task2)
      @new_project.add_task(task3)
      @new_project.complete(task.id)
      @new_project.complete(task2.id)

      @new_project.retrieve_completed_tasks
      result = @new_project.completed_tasks
      expect(result).to eq [task, task2]
    end
  end


end
