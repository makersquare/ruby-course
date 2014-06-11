require 'spec_helper'

describe 'Task' do
  # let(:project    ) { TM::Project.new('Test Project') }
  # let(:description) { 'My Task' }
  # let(:priority   ) { 1 }
  # let(:task       ) { klass.new(description, priority, project.id) }

  let(:klass) { TM::Task }

  before(:each) do
    klass.class_variable_set :@@counter, 0
    klass.class_variable_set :@@tasks, [ ]

    @project = TM::Project.new("Test Project")
    @task1 = klass.new(@project.id, 1, "Task 1").complete
    @task2 = klass.new(@project.id, 2, "Task 2").complete
    @task3 = klass.new(@project.id, 3, "Task 3")
    @task4 = klass.new(@project.id, 4, "Task 4")
  end

  it "exists" do
    expect(klass).to be_a(Class)
  end

  it "responds to find given a task_id by returning the task" do
    expect(klass.find(@task1.id)).to eq(@task1)
  end

  it "responds to all by returning all tasks" do
    expect(klass.all.first).to be_a(klass)
    expect(klass.all.length).to eq(4)
  end

  context "responds to tasks_for given a project_id" do
    it "when incomplete" do
      expect(klass.tasks_for(@project.id).length).to eq(2)
      expect(klass.tasks_for(@project.id).first).to eq(@task3)
    end
    it "when complete by passing an optional parameter 'true'" do
      expect(klass.tasks_for(@project.id, true).length).to eq(2)
      expect(klass.tasks_for(@project.id, true).first).to eq(@task1)
    end
  end

  it "can be created with a project_id, priority, description" do
    expect(@task1.project_id).to eq(@project.id)
    expect(@task1.priority).to eq(1)
    expect(@task1.description).to eq('Task 1')
  end

  it "is given a default ID and created_at time" do
    # time = Time.new(2014,01,01,15,10)
    # expect(Time).to receive(:now).and_return(time)
    # expect(@task1).to receive(:id).and_return(1)

    expect(@task1.id).to eq(1)
    expect(@task1.created_at).to be_a(Time)
  end

  it "responds to set_complete given a task_id by setting the task to complete" do
    expect( @task3.complete? ).to eq(false)
    expect(klass.set_complete(@task3.id).complete?).to eq(true)
  end
end
