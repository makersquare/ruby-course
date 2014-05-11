require 'spec_helper'

# #allow(Time).to receive(:now).and_return(Time.parse("3PM"))

describe 'Task' do
  before(:each) do
    @db = TM.db
    @db.create_task({description: "New Task", priority: 1, pid: 1})
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  context 'a new task is initialized' do
    # let(:task) { TM::Task.new(1, 1, "complete this task manager") }
    # let(:task2) { TM::Task.new(1, 1, "complete this task manager", "maker","square") }
    it 'creates a new task with a description' do
      expect(@db.get_task(1).description).to eq("New Task")
    end

    it 'creates a new task with a project id' do
      expect(@db.get_task(1).pid).to eq(1)
    end

    # it 'creates a new task with a priority' do
    #   expect(task.priority).to eq(1)
    # end

    # it 'has a due date' do
    #   # allow(TM::Task).to receive(:now).and_return(Time.parse("12PM"))

    #   expect(task.complete_date).to eq(task.date_created + (86400 * 5))
    # end

  end

#   context 'a task is completed' do
#     let(:task) { TM::Task.new(1, 1, "complete this task manager") }

#     it "has an initial status of completed" do
#       expect(task.completed).to eq(false)
#     end

#     it "changes it's status of complete to true" do
#       task.complete
#       expect(task.completed).to eq(true)
#     end
#   end
end
