require 'spec_helper'

describe 'Project' do
  let(:test){TM::Project.new('first')}
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end
  context 'project is started with a name' do
    it 'has a name' do
      expect(test.name).to eq('first')
    end
  end
  context 'starting a new project' do
    it 'has an id number' do
      expect(test.id).to be_a(Fixnum)
    end
  end
  context 'create a new task' do
    it 'adds a task to the tasks array' do
      test.add_task("new task",1)
      expect(test.tasks.length).to eq(1)
      test.add_task("new task",2)
      expect(test.tasks.length).to eq(2)
    end
  end
  describe '#complete_task' do
    it 'marks a task complete' do
      id=test.add_task("new task",1)
      # binding.pry
      test.complete_task(id)
      expect(test.tasks[id].completed).to be_true
    end
  end
  describe '#list_complete_tasks' do
    context 'when called with no tasks' do
      it 'returns an empty array' do
        expect(test.list_complete_tasks).to eq([])
      end
    end
    context 'when called with no completed tasks' do
      it 'returns an empty array' do
        test.add_task("new task",1)
        expect(test.list_complete_tasks).to eq([])
      end
    end
    context 'when called with 1 completed tasks' do
      it 'returns an empty array' do
        id=test.add_task("new task",1)
        test.complete_task(id)
        expect(test.list_complete_tasks.length).to eq(1)
      end
    end
  end
end
