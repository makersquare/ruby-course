require 'spec_helper'

describe 'Project' do
  let(:klass    ) { TM::Project }
  let(:name     ) { 'Blah' }
  let(:project  ) { klass.new(name) }

  it "exists" do
    expect(klass).to be_a(Class)
  end

  it "must have a name" do
    expect(project.name).to eq(name)
  end

  it "must have an ID" do
    expect(project.id).to eq(2)
  end

  it "allows tasks to be created" do
    # task = double('Task', :description => 'new task',
    #                       :priority    => 1,
    #                       :project_id  => project.id)

    expect( project.new_task('new task', 1) ).to be_a(TM::Task)
  end

  it "retrieves a list of completed tasks sorted by priority" do
    # task1 = double('Task', :status => :complete, :priority => 1)
    # task2 = double('Task', :status => :complete, :priority => 2)
    # completed = [task1, task2]
    # allow(project).to receive(:completed_tasks).and_return(completed)

    # expect(project.completed_tasks).to eq(completed)

    task1 = project.new_task('new task', 1)
    task1.complete
    task2 = project.new_task('new task', 2)
    task2.complete

    task_array = project.completed_tasks
    expect(task_array).to be_a(Array)

    expect(task_array.first).to be_a(TM::Task)
    expect(task_array.first.priority).to be < task_array.last.priority
  end

  describe "it retrieves a list of incompleted tasks sorted by priortiy" do
    it "must" do
      # task1 = double('Task', :status => :incomplete, :priority => 1)
      # task2 = double('Task', :status => :incomplete, :priority => 2)
      # incompleted = [task1, task2]
      # allow(project).to receive(:incompleted_tasks).and_return(incompleted)

      # expect(project.incompleted_tasks).to eq(incompleted)

      task1 = project.new_task('new task', 1)
      task2 = project.new_task('new task', 2)

      task_array = project.incompleted_tasks
      expect(task_array).to be_a(Array)

      expect(task_array.first).to be_a(TM::Task)
      expect(task_array.first.priority).to be < task_array.last.priority
    end

    context "when two tasks have the same priority number" do
      it "the older task gets priority" do
        time = Time.new(2014,01,01,15,10)
        expect(Time).to receive(:now).twice.and_return(time, time - 1000)

        task1 = project.new_task('newer', 1)
        task2 = project.new_task('older', 1)

        task_array = project.incompleted_tasks
        expect(task_array).to be_a(Array)

        expect(task_array.first).to be_a(TM::Task)
        expect(task_array.first.description).to eq('older')
      end
    end
  end
end
