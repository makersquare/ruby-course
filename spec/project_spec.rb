require 'spec_helper'

describe 'Project' do

  let(:klass) { TM::Project }

  before(:each) do
    klass.class_variable_set :@@counter, 0
    klass.class_variable_set :@@projects, [ ]
    TM::Task.class_variable_set :@@counter, 0
    TM::Task.class_variable_set :@@tasks, [ ]

    @project = klass.new("Test Project")
    @task1 = TM::Task.new(@project.id, 1, "Task 1").complete
    @task2 = TM::Task.new(@project.id, 2, "Task 2").complete
    @task3 = TM::Task.new(@project.id, 3, "Task 3")
    @task4 = TM::Task.new(@project.id, 4, "Task 4")
  end

  it "exists" do
    expect(klass).to be_a(Class)
  end

  it "must have a name" do
    expect(@project.name).to eq('Test Project')
  end

  it "must have an ID" do
    expect(@project.id).to eq(1)
  end

  it "instance responds to new_task provided priority and description" do
    expect( @project.new_task(5, "Task 5") ).to be_a(TM::Task)
    expect( @project.incompleted_tasks.length).to eq(3)
  end

  it "responds to all by returning all projects" do
    expect( klass.all.length ).to eq(1)
    expect( klass.all.first ).to be_a(klass)
  end

  it "responds to find given an id by returning the project" do
    expect(klass.find(@project.id)).to be_a(klass)
    expect(klass.find(@project.id)).to eq(@project)
  end

  it "retrieves a list of completed tasks sorted by priority" do
    task_array = @project.completed_tasks
    expect(task_array).to be_a(Array)
    expect(task_array.first).to be_a(TM::Task)
    expect(task_array.first.complete?).to eq(true)
    expect(task_array.first.priority).to be < task_array.last.priority
  end

  describe "it retrieves a list of incompleted tasks sorted by priortiy" do
    it "must" do
      task_array = @project.incompleted_tasks
      expect(task_array).to be_a(Array)
      expect(task_array.first).to be_a(TM::Task)
      expect(task_array.first.complete?).to eq(false)
      expect(task_array.first.priority).to be < task_array.last.priority
    end

    context "when two tasks have the same priority number" do
      it "the older task gets priority" do
        time = Time.new
        expect(Time).to receive(:now).twice.and_return(time - 1000, time)

        task5 = TM::Task.new(@project.id, 5, "Task 5")
        task6 = TM::Task.new(@project.id, 5, "Task 6")

        task_array = @project.incompleted_tasks
        expect(task_array[-1].created_at).to be > task_array[-2].created_at
      end
    end
  end
end
