require 'spec_helper'
require 'time'


describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '#initialize' do
    # before(:each) do
    #   task1 = TM::Task.new("task1",5, "description", 1)
    # end
    it "has a name" do
      task1 = TM::Task.new("task1",5, "description", 1)
      expect(task1.name).to eq("task1")
    end

    it "has a creation date" do
      task1 = TM::Task.new("task1",5, "description", 1)
      # allow(Time).to receive(:now).and_return(Time.parse(#look up date)
      # expect(task1.creation_date).to eq(#whatever date)
    end

    it "has a priority number" do
      task1 = TM::Task.new("task1",5, "description", 1)
      expect(task1.priority_number).to eq(5)
    end

    it "has a status of available" do
      task1 = TM::Task.new("task1",5, "description", 1)
      expect(task1.status).to eq("incomplete")
    end

    xit "will return nil if the priority number is not inclusive of 1..5" do
      task1 = TM::Task.new("task1",6, "description", 1)
      expect(task1.priority_number).to eq(nil)
    end
  end

  describe '#mark_complete and #mark_incomplete'
    it "marks a task as complete and then back to incomplete" do
      task1 = TM::Task.new("task1",5, "description", 1)
      expect(task1.status).to eq("incomplete")

      task1.mark_complete
      expect(task1.status).to eq("complete")

      task1.mark_incomplete
      expect(task1.status).to eq("incomplete")
    end
  end
end
