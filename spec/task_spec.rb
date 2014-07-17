require 'spec_helper'
require 'pry-debugger'

describe 'Task' do

  let(:t1) { TM::Task.new(1, 1, 'Task 1', 1, '2014 1 1', '2014 5 12', false)}
  let(:t2) { TM::Task.new(1, 2, 'Task 2', 3, '2014 6 6', '2014 5 12', false)}

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '#initialize' do
    it "A new task can be created with a project id, description, priority number, and due date(y m d)." do
      expect(t1.pid).to eq(1)
      expect(t1.tid).to eq(1)
      expect(t1.desc).to eq("Task 1")
      expect(t1.pnum).to eq(1)
      expect(t1.duedate).to eq('2014 1 1')
      expect(t1.date).to eq('2014 5 12')
      expect(t1.complete).to eq(false)

      expect(t2.pid).to eq(1)
      expect(t2.tid).to eq(2)
      expect(t2.desc).to eq("Task 2")
      expect(t2.pnum).to eq(3)
      expect(t2.duedate).to eq('2014 6 6')
      expect(t2.date).to eq('2014 5 12')
      expect(t2.complete).to eq(false)
    end
  end

end
