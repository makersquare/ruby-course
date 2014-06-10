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
      it 'returns an array containing that task' do
        id=test.add_task("new task",1)
        test.complete_task(id)
        expect(test.list_complete_tasks.length).to eq(1)
        expect(test.list_complete_tasks[0]).to be_a(TM::Task)
      end
    end
    context 'when called with several completed tasks and several incompleted tasks' do
      it 'returns an array with the completed tasks' do
        id=test.add_task("new task",1)
        id1=test.add_task("new task",2)
        id2=test.add_task("new task",300)
        id3=test.add_task("new task",1)
        id4=test.add_task("new task",3)
        test.complete_task(id)
        test.complete_task(id2)
        expect(test.list_complete_tasks.length).to eq(2)
        expect(test.list_complete_tasks[0]).to be_a(TM::Task)
      end
      it 'also returns tasks in order of creation date' do
        id=test.add_task("new task",1)
        id1=test.add_task("new task",2)
        id2=test.add_task("new task",300)
        id3=test.add_task("new task",1)
        id4=test.add_task("new task",3)
        test.complete_task(id)
        test.complete_task(id2)
        new_date=test.list_complete_tasks[0].date<test.list_complete_tasks[1].date
        expect(new_date).to be_true
      end
    end
  end

  describe '#list_incomplete_tasks' do
    context 'when called with no tasks' do
      it 'returns an empty array' do
        expect(test.list_complete_tasks).to eq([])
      end
    end
    context 'when called with 1 incompleted tasks' do
      it 'returns an array containing that task' do
        test.add_task("new task",1)
        expect(test.list_incomplete_tasks.length).to eq(1)
        expect(test.list_incomplete_tasks[0]).to be_a(TM::Task)
      end
    end
    context 'when called with 1 completed tasks' do
      it 'returns an empty array' do
        id=test.add_task("new task",1)
        test.complete_task(id)
        expect(test.list_incomplete_tasks).to eq([])
      end
    end
    context 'when called with several completed tasks and several uncompleted tasks' do
      it 'returns an array with the incompleted tasks' do
        id=test.add_task("new task",1)
        id1=test.add_task("new task",2)
        id2=test.add_task("new task",300)
        id3=test.add_task("new task",1)
        id4=test.add_task("new task",3)
        test.complete_task(id)
        test.complete_task(id2)
        expect(test.list_incomplete_tasks.length).to eq(3)
        expect(test.list_incomplete_tasks[0]).to be_a(TM::Task)
      end
      it 'in order of priority' do
        id=test.add_task("new task",1)
        id1=test.add_task("new task",2)
        id2=test.add_task("new task",300)
        id3=test.add_task("new task",1)
        id4=test.add_task("new task",3)
        test.complete_task(id)
        test.complete_task(id2)
        prior=test.list_incomplete_tasks[0].priority<test.list_incomplete_tasks[1].priority
        expect(prior).to be_true
        prior=test.list_incomplete_tasks[-1].priority<test.list_incomplete_tasks[0].priority
        expect(prior).to be_false
        prior=test.list_incomplete_tasks[-1].priority<test.list_incomplete_tasks[0].priority
        expect(prior).to be_false
      end

    end
  end
end
