require 'spec_helper'
require 'timecop'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  before(:all) do
    @task = TM::Task.new(25, 'Pay credit card', 10)
  end

  describe '.initialize' do
    it 'has a project id' do
      expect(@task.project).to eq(25)
    end

    it 'has a priority' do
      expect(@task.priority).to eq(10)
    end

    it 'has a description' do
      expect(@task.description).to eq('Pay credit card')
    end

    it 'is not complete by default' do
      expect(@task.complete).to eq(false)
    end

    it 'has a creation date' do
      Timecop.freeze(Time.now)
      task = TM::Task.new(1,1,"nothing")

      expect(task.created).to eq(Time.now)
    end

    it 'has a unique id' do
      expect(@task.id).to eq(:P25_T1)
    end

    it 'is a member of the task hash' do
      expect(TM::Task.task_list[@task.id].description).to eq(@task.description)
    end
  end

  describe '.mark_complete' do
    it 'can mark a task as done' do
      @task.done()

      expect(@task.complete).to eq(true)
    end
  end
end
