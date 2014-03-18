require 'spec_helper'

describe 'Project' do
  before do
    expect(TM::Project).to receive(:generate_id).and_return(0)
    @new_project = TM::Project.new('project name')
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
      expect(result).to eq(0)
    end
  end

  describe '#add_task' do
    it 'adds a task to the project' do
      task = TM::Task.new("take out the trash")
      @new_project.add_task(task)
      result = @new_project.tasks[0]
      expect(result).to eq(task)
    end
    it 'assigns the respective project id to project_id' do
      task = TM::Task.new("take out the trash")
      @new_project.add_task(task)
      result = task.project_id
      expect(result).to eq(0)
    end

  describe '#mark_task_complete' do
    it 'marks a task identified by its id as complete' do
      task = TM::Task.new("take out the trash")

      @new_project.add_task(task)
      @new_project.mark_task_complete(3)
      result = task.complete

      expect(result).to eq(true)

    end

  end

end

end
