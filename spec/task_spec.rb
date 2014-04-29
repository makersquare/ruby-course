require 'spec_helper'

describe 'Task' do
  before do
    TM::Task.reset_id_count
    @t1 = TM::Task.new(1, "do this", 5)
    @t2 = TM::Task.new(1, "do that", 5)
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "initializes with project id, desc, and priority" do
    expect(@t1).to be_a(TM::Task)
    expect(@t1.project_id).to eq(1)
    expect(@t1.desc).to eq("do this")
    expect(@t1.priority).to eq(5)
    expect(@t1.complete).to eq(false)
  end

  it "initializes with a unique id" do
    t1 = TM::Task.new(1, "do this", 5)
    t2 = TM::Task.new(1, "do that", 5)
    expect(@t1.id).to eq(1)
    expect(@t2.id).to eq(2)
  end

  it "should complete a task based on a task id" do
    expect(@t1.complete).to eq(false)
    id = @t1.id
    TM::Task.mark_complete(id)
    expect(@t1.complete).to eq(true)
  end
end
