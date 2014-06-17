require 'spec_helper'


describe 'Project' do
  let(:project_x) { TM::Project.new('project x') }

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe '.initialize' do
    it 'should be created with a name, id, and task list' do

      expect(project_x.task_list).to be_a Hash
      expect(project_x.name).to eq 'project x'
      expect(project_x.id).to eq 0
    end
  end

  describe '.add_task' do
    it 'should create a task and add it to the task list' do
      project_x.add_task('clean my room', 10)

      expect(project_x.task_list.size).to eq 1
      expect(project_x.task_list['0.0']).to be_a TM::Task
    end
  end

  describe '.complete' do
    it 'should set a task to complete' do
      project_x.add_task('clean my room', 10)

      project_x.complete('1.0')

      expect(project_x.task_list['1.0'].status).to eq 'complete'
    end
  end

  describe '.list_complete' do
    it 'should return an array of completed tasks (chrono order)' do
      project_x.add_task('clean my room', 10)
      project_x.add_task('grocery shop', 8)
      project_x.add_task('laundry', 8)

      project_x.complete('2.0')
      project_x.complete('2.2')

      # binding.pry
      expect(project_x.list_complete).to eq [['2.0', project_x.task_list['2.0']], ['2.2', project_x.task_list['2.2']]]
    end
  end

  describe '.list_tasks' do
    it 'should return an array of NOT completed tasks (priority order)' do
      project_x.add_task('clean my room', 10)
      project_x.add_task('grocery shop', 8)
      project_x.add_task('laundry', 10)
      project_x.complete('3.1')
      # binding.pry
      expect(project_x.list_tasks).to eq [['3.2', project_x.task_list['3.2']], ['3.0', project_x.task_list['3.0']]]
    end
  end
end








