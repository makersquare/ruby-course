require 'spec_helper'
require 'pry'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  context 'a project is initalized' do
    let(:project) { TM::Project.new("My_first_project") }

    it 'initializes with a name' do
        expect(project.name).to eq("My_first_project")
    end

     it 'creates a unique ID' do
      expect(project.id).to eq(2)
    end

  end

  context 'a project can see task' do
    it 'can see a list of task by creation date' do
    end

    it 'can retrieve a list of incompleted task sorted by priority' do
    end
  end

  context 'a task has the same priority number as another task' do
    it 'gives the older project precedence' do
    end
  end

  context 'a project can see all uncompleted task' do
    let(:project) { TM::Project.new("My_first_project") }
    let(:task1) { TM::Task.new(1, 1, "complete this task manager") }
    let(:task2) { TM::Task.new(1, 2, "complete this task manager like now") }
    let(:task3) { TM::Task.new(1, 2, "complete this task manager like YESTERDAY") }

    it 'can accept new task' do
      project.task << task3
      project.task << task2
      project.task << task1
      expect(project.task.count).to eq(3)
    end

    it 'list uncompleted completed task in order of creation date' do
      allow(Time).to receive(:now).and_return(Time.parse("12PM"))
      task1 = TM::Task.new(1, 1, "complete this task manager").complete
      allow(Time).to receive(:now).and_return(Time.parse("3PM"))
      task2 = TM::Task.new(1, 2, "complete this task manager like now").complete
      allow(Time).to receive(:now).and_return(Time.parse("5PM"))
      task3 = TM::Task.new(1, 2, "complete this task manager YESTERDAY")
      project.task << task3
      project.task << task2
      project.task << task1

      expect(project.completed_task).to eq([task1, task2])
    end
  end
end
