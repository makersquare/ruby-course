require 'spec_helper'

describe 'Task' do
  let(:task) { TM::Task.new(1, "eat 20 cheese wheels", 2) }

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '.initialize' do
    it 'creates a task with a project id, description, and priority number' do
      expect(task.proj_id).to eq(1)
      expect(task.description).to eq("eat 20 cheese wheels")
      expect(task.priority).to eq(2)
    end

    it 'generates a unique id for each task' do
      expect(TM::Task).to receive(:gen_id).and_return(1)
      expect(task.id).to eq(1)
    end
  end


end
