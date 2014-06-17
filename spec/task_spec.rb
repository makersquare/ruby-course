require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end
  context 'initializes' do
    it 'values' do
      task1 = TM::Task.new('lunch', 1)
      task2 = TM::Task.new('code', 10)
      task3 = TM::Task.new('sleep', 2)
      expect(task1.desc).to eq('lunch')
      expect(task2.key).to eq(10)
      expect(task3.done).to eq(false)
      # test ids are unique
      # task1.id != task2.id
    end
  end
  it 'completes tasks' do
    task1 = TM::Task.new('lunch', 1)
    expect(task1.done).to eq(false)
    task1.complete
    expect(task1.done).to eq(true)
  end
end
