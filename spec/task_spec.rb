require 'spec_helper'


describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '#initialize' do

    before do
      @task1 = TM::Task.new("task1",5, "description", 1)
    end

    it "has a name" do
      expect(@task1.name).to eq("task1")
    end

    it "has a creation date" do
      allow(@task1).to receive(:creation_date).and_return("3:00")
      expect(@task1.creation_date).to eq("3:00")
    end

    it "has a priority number" do
      # task1 = TM::Task.new("task1",5, "description", 1)
      expect(@task1.priority_number).to eq(5)
    end

    it "has a status of available" do
      # task1 = TM::Task.new("task1",5, "description", 1)
      expect(@task1.status).to eq("incomplete")
    end
  end

  describe "#priority_number" do
    it "will return nil if the priority number is not inclusive of 1..5" do
      task1 = TM::Task.new("task1",6, "description", 1)
      expect(task1.priority_number).to eq(5)
    end
  end

end
