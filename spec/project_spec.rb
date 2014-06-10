require 'spec_helper'

describe 'Project' do
  let(:klass    ) { TM::Project }
  let(:name     ) { 'Blah' }
  let(:project  ) { klass.new(name) }

  # let(:task) do
  #   task = mock_model(TM::Task)
  #   task.stub!(:status)
  #   task.stub!(:priority)
  # end

  # let(:task1) do
  #   task.status = :complete
  #   task.priority = 1
  #   task
  # end

  # let(:completed) { [task, task, task] }

  it "exists" do
    expect(klass).to be_a(Class)
  end

  it "must have a name" do
    expect(project.name).to eq(name)
  end

  it "must have an ID" do
    expect(project.id).to eq(2)
  end

  it "retrieves a list of complete tasks sorted by priority" do
    task1 = double('Task', :status => :complete, :priority => 1)
    task2 = double('Task', :status => :complete, :priority => 2)
    completed = [task1, task2]
    allow(project).to receive(:completed).and_return(completed)

    expect(project.completed).to eq(completed)
  end

  describe "it retrieves a list of incomplete tasks sorted by priortiy" do
    it "must" do
      task1 = double('Task', :status => :incomplete, :priority => 1)
      task2 = double('Task', :status => :incomplete, :priority => 2)
      incompleted = [task1, task2]
      allow(project).to receive(:incompleted).and_return(incompleted)

      expect(project.incompleted).to eq(incompleted)
    end

    context "when two tasks have the same priority number" do
      it "the older task gets priority"
    end
  end
end
