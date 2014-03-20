require 'spec_helper'

describe 'Project' do
  before do
    TM::Project.class_variable_set :@@counter, 0
    # expect(TM::Project).to receive(:generate_id).at_least(:once).and_return(0)
    @new_project = TM::Project.new('project name')

    TM::Task.class_variable_set :@@counter, 0
    # expect(TM::Task).to receive(:generate_id).at_least(:once).and_return(0)
    @new_task = TM::Task.new('take out the trash')
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
      result = @new_project.id
      expect(result).to eq(1)
    end
  end

  describe '#add_task' do
    it 'adds a task to the project' do
      # task = TM::Task.new("take out the trash")
      @new_project.add_task(@new_task)
      result = @new_project.tasks[0]
      expect(result).to eq(@new_task)
    end
    it 'assigns the respective project id to project_id' do
      # task = TM::Task.new("take out the trash")
      @new_project.add_task(@new_task)
      result = @new_task.project_id
      expect(result).to eq(1)
    end

  describe '#mark_task_complete' do
    it 'marks a task identified by its id as complete' do
      # task = TM::Task.new("take out the trash")

      @new_project.add_task(@new_task)
      @new_project.mark_task_complete(@new_task.id)
      result = @new_task.complete

      expect(result).to eq(true)

    end

  end

  describe '#retrieve_completed_tasks' do
    it 'retrieves a list of completed tasks by creation date' do
      task = TM::Task.new('pee on front lawn')
      task_two = TM::Task.new('poo on front lawn')
      task_three = TM::Task.new('clean the front lawn')

      @new_project.add_task(task)
      @new_project.add_task(task_two)
      @new_project.add_task(task_three)

      @new_project.mark_task_complete(task.id)
      @new_project.mark_task_complete(task_two.id)
      # binding.pry
      result = @new_project.retrieve_completed_tasks
      expect(result).to eq([task, task_two])
      # expect(result[1]).to eq(task_two)



    end
  end

  describe '#retrieve_incomplete_tasks' do
    it 'retrieves incomplete tasks by priority' do
      task = TM::Task.new('pee on front lawn', 2)
      task_two = TM::Task.new('poo on front lawn', 2)
      task_three = TM::Task.new('clean the front lawn', 1)

      @new_project.add_task(task)
      @new_project.add_task(task_two)
      @new_project.add_task(task_three)

      result = @new_project.retrieve_incomplete_tasks
      expect(result).to eq([task_three, task_two, task])

    end
  end

end

end
