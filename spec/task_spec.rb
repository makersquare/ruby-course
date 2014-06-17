require 'spec_helper'

describe 'Task' do
  before(:all) do
    TM::Task.class_variable_set :@@tasks, []
    TM::Task.class_variable_set :@@counter, 0
    @t1 = TM::Task.new 1, 1, "Clean walls"
    @t2 = TM::Task.new 2, 1, "Put down drop cloth"
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "has a priority number, tid, description, a project id, and a complete status of false" do
    expect(@t1.priority).to eq 1
    expect(@t1.description).to eq "Clean walls"
    expect(@t1.pid).to eq 1
    expect(@t1.tid).to eq 1
    expect(@t1.status).to eq :incomplete
    expect(@t2.priority).to eq 2
    expect(@t2.description).to eq "Put down drop cloth"
    expect(@t2.pid).to eq 1
    expect(@t2.tid).to eq 2
    expect(@t2.status).to eq :incomplete
  end

  it "pushes tasks onto an array" do
    expect(TM::Task.get_tasks).to eq([@t1, @t2])
  end

  it "can mark a task complete" do
    mark = TM::Task.mark_complete 1
    expect(mark).to eq :complete
  end
end
