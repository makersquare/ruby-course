require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end
  describe '#initialize' do
    let(:task){TM::Task.new(0,"new task",1,0)}
    context 'new task is created with a project id a description and a priority number' do
      it 'has the project id' do
        expect(task.project_id).to eq(0)
      end
      it 'has a description' do
        expect(task.description).to eq("new task")
      end
      it 'has a priority number' do
        expect(task.priority).to eq(1)
      end
      it 'has a default status of uncompleted' do
        expect(task.completed).to eq(false)
      end
      it 'has an id number' do
        expect(task.id).to eq(0)
      end
      it 'has a creation date' do
        expect(task.date).to be_a(Time)
      end
    end
  end
  describe '#change_status' do
    it 'marks a task complete' do
      task1=TM::Task.new(0,"new task",1,0)
      task1.change_status
      expect(task1.completed).to be_true
    end
  end
end

