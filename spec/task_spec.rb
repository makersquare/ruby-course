require 'spec_helper'
require 'pry-debugger'

describe 'Task' do
  before do
    TM::Task.reset_class_variables
  end

  let(:t1) { TM::Task.new(1, "do this", 5) }
  let(:t2) { TM::Task.new(1, "do that", 5) }

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "initializes with project id, desc, and priority" do
    expect(t1).to be_a(TM::Task)
    expect(t1.project_id).to eq(1)
    expect(t1.desc).to eq("do this")
    expect(t1.priority).to eq(5)
    expect(t1.complete).to eq(false)
  end

  it "initializes with a unique id" do
    expect(t1.id).to eq(1)
    expect(t2.id).to eq(2)
  end

  it "should complete a task based on a task id" do
    expect(t1.complete).to eq(false)
    id = t1.id
    TM::Task.mark_complete(id)
    expect(t1.complete).to eq(true)
  end

  describe "#retrieve_tasks" do
    TM::Task.reset_class_variables
    before do
      @tasks = [
        TM::Task.new(1, "task", 2),
        TM::Task.new(1, "task", 2),
        TM::Task.new(1, "task", 1),
        TM::Task.new(1, "task", 1),
        TM::Task.new(1, "task", 2),
        TM::Task.new(1, "task", 1),
        TM::Task.new(2, "task", 0),
        TM::Task.new(2, "task", 0)
      ]
      @tasks[0].complete = true
      @tasks[1].complete = true
      @tasks[2].complete = true
    end

    let(:complete) {TM::Task.retrieve_tasks(1, true)}
    let(:incomplete) {TM::Task.retrieve_tasks(1, false)}
    context "complete tasks" do
      it "returns a list of tasks given a project id and completion" do
        expect(complete).to include(@tasks[0], @tasks[1], @tasks[2])
        expect(complete).to_not include(@tasks[3],
          @tasks[4], @tasks[5], @tasks[6], @tasks[7])
      end
    end

    context "incomplete tasks" do
      it "returns a list of tasks given a project id and completion" do
        expect(incomplete).to include(@tasks[3], @tasks[4], @tasks[5])
        expect(incomplete).to_not include(@tasks[0], @tasks[1], @tasks[2],
          @tasks[6], @tasks[7])
      end
    end

    it "returns the result in order of priority" do
      expect(complete).to eq([@tasks[2], @tasks[0], @tasks[1]])
      expect(incomplete).to eq([@tasks[3], @tasks[5], @tasks[4]])
    end
  end
end
