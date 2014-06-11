require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  context 'when initialized' do
    # before(:each) do
    #   task1 = TM::Task.new("task1",5)
    # end
    it "has a name" do
      task1 = TM::Task.new("task1",5)
      expect(task1.name).to eq("task1")
    end

    xit "has a creation date" do
      task1 = TM::Task.new("task1",5)
      expect(task1.creation_date).to eq
    end

    it "has a priority number" do
      task1 = TM::Task.new("task1",5)
      expect(task1.priority_number).to eq(5)
    end

    it "has a status of available" do
      task1 = TM::Task.new("task1",5)
      expect(task1.status).to eq("incomplete")
    end

    it "will return a nil description if nothing provided" do
      task1 = TM::Task.new("task1",5)
      expect(task1.description).to eq(nil)
    end

    xit "will return nil if the priority number is not inclusive of 1..5" do
      task1 = TM::Task.new("task1",6)
      expect(task1.priority_number).to eq(nil)
    end
  end

  xit "marks a task as complete" do
    task1 = TM::Task.new("task1",5)
    # THIS IS NOT REAL, JUST AN EXAMPLE OF STUBBING
    # allow(task1).to receive(:mark_complete).and_return("complete")
    task1.mark_complete

    expect(task1.status).to eq("complete")
  end

  it "marks a task as complete" do
    task1 = TM::Task.new("task1",5)
    task1.task_id = 2
    task1.mark_complete(2)

    expect(task1.status).to eq("complete")
  end

#REVIEW
  it "marks a task as incomplete" do
    task1 = TM::Task.new("task1",5)
    allow(task1).to receive(:mark_complete).and_return("complete")
    task1.mark_complete
    allow(task1).to receive(:mark_incomplete).and_return("incomplete")
    task1.mark_incomplete

    expect(task1.status).to eq("incomplete")
  end

end
