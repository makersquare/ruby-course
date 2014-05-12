require 'spec_helper'
require 'pry-debugger'

describe 'Task' do

  before(:each) do
    TM::Task.reset_class_variables
    @p1 = TM::Project.new("Project 1")
    @t1 = TM::Task.new(1, 'Task 1', 1, '2014 1 31')
    @t2 = TM::Task.new(1, 'Task 2', 2, '2014 5 6')
  end

  xit "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '#initialize' do
    xit "A new task can be created with a project id, description, priority number, and due date(y m d)." do
      expect(@t1.tid).to eq(1)
      expect(@t1.description).to eq("Task 1")
      expect(@t1.pnum).to eq(1)
      expect(@t1.duedate).to eq('2014 1 31')
    end
  end

end
