require 'spec_helper'

describe 'Task' do

  # the 'let' method creates a local variable like this:
  #
  # task = TM::Task.new(1, "eat 20 cheese wheels", 2)
  #
  # the neat thing is this local variable can be used throughout this describe block

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

    it 'defaults the task as being incompleted' do
      # expect the @completed variable in initialize method to start as false
      expect(task.completed).to eq(false)
    end

    it 'gives the task a creation date' do

      # stub time so that Time.now stays consistent throughout test
      #
      # arbitratily chose Time.parse('2 pm')
      #
      Time.stub(:now).and_return(Time.parse('2 pm'))
      created_time_stub = Time.now

      # expect the time_created method to give time task was created at
      #
      # the task .initialize will have @time_created = Time.now
      #
      expect(task.time_created).to eq(created_time_stub)
    end

  end


end
