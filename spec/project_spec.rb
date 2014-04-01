require 'spec_helper'

describe 'Project' do
  before do
    TM::Project.class_variable_set :@@counter, 0
    @new_project = TM::Project.new('projname')

    TM::Task.class_variable_set :@@counter, 0
    @task = TM::Task.new("description")
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
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

  # describe 'add_task' do
  #   it "adds a task to project" do
  #     #task = TM::Task.new("description")
  #     @new_project.add_task(@task)
  #     result = @new_project.tasks[0]
  #     expect(result).to eq @task
  #   end

  #   it "assigns the correct id to the task" do
  #     #task = TM::Task.new("description")
  #     @new_project.add_task(@task)
  #     result = @task.project_id
  #     expect(result).to eq 1
  #   end
  # end

  # describe 'complete' do
  #   it 'marks a task complete by id' do
  #     #task = TM::Task.new("description")
  #     @new_project.add_task(@task)
  #     @new_project.complete(1)
  #     result = @task.complete
  #     expect(result).to eq true
  #   end
  # end

  # describe 'retreive completed tasks, by date' do
  #   it 'retrieves a list of completed tasks by date' do
  #     task1 = TM::Task.new('bla')
  #     task2 = TM::Task.new('blablabla')
  #     task3 = TM::Task.new('noshow')
  #     # binding.pry
  #     @new_project.add_task(task1)
  #     @new_project.add_task(task2)
  #     @new_project.add_task(task3)
  #     @new_project.complete(task1.id)
  #     @new_project.complete(task2.id)

  #     result = @new_project.retrieve_completed_tasks
  #     expect(result).to eq [task2, task1]
  #   end
  # end

  # describe 'retreive incomplete tasks, by priority' do
  #   xit 'retrieves a list of incomplete tasks by priority' do
  #     task = TM::Task.new('bla', 2)
  #     task2 = TM::Task.new('blablabla', 1)
  #     task3 = TM::Task.new('noshow', 4)
  #     @new_project.add_task(task)
  #     @new_project.add_task(task2)
  #     @new_project.add_task(task3)
  #     @new_project.complete(task.id)
  #     # binding.pry
  #     result = @new_project.retrieve_incomplete_tasks
  #     expect(result).to eq [task2, task3]
  #   end
  # end
end
