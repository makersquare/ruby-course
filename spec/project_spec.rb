require 'spec_helper'
require 'pry'

describe 'Project' do

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  context 'a project is initalized' do
    let(:project) { TM::Project.new("My_first_project", 1, false) }

    it 'initializes with a name' do
        expect(project.name).to eq("My_first_project")
    end

    it 'initializes with a uniquie id' do
      expect(project.id).to eq(1)
    end

    it 'initalizes wiht a completed status of fasle' do
      expect(project.completed?).to eq(false)
    end

  end

  context 'a project can be updated' do
    before(:each) do
      @db = TM.db
      @db.create_project({ :name => "Pizza Party Planning" })
      @new_project = @db.get_project(1)
    end

    it 'can make a project as complete' do
      @new_project.complete_project
      expect(@db.get_project(1).completed?).to eq(true)
    end
  end

  context 'a project is created and task are assigned to it' do
    before(:each) do
      @db = TM.db
      @db.create_project({ :name => "Pizza Party Planning" })
      @new_project = @db.get_project(1)
      @db.create_task({description: "Second Task", priority: 2, pid: 1})
      @db.create_task({description: "First Task", priority: 1, pid: 1})
    end

    it 'can can get a list of incomplete task' do
      expect(@new_project.incomplete_task.length).to eq(2)
      # binding.pry
    end

    it 'can can list incomplete task by priority' do
      expect(@new_project.incomplete_task.first[:priority]).to eq(1)
    end

    it 'can show a list of completed task' do
      TM.db.get_task(2).complete_task
      # binding.pry
      expect(@new_project.completed_task.first[:description]).to eq("First Task")
    end
  end

  # context 'a project can see all incompleted task' do
  #   let(:project) { TM::Project.new("My_first_project") }
  #   let(:projects_manger) { TM::ProjectsManager.new }
  #   let(:task1) { TM::Task.new(1, 1, "complete this task manager") }
  #   let(:task2) { TM::Task.new(1, 2, "complete this task manager like now") }
  #   let(:task3) { TM::Task.new(1, 2, "complete this task manager like YESTERDAY") }

  #   it 'can accept new task' do
  #     project.task << task3
  #     project.task << task2
  #     project.task << task1
  #     expect(project.task.count).to eq(3)
  #   end

  #   it 'list completed task in order of creation date' do
  #     allow(Time).to receive(:now).and_return(Time.parse("12PM"))
  #     task1 = TM::Task.new(1, 1, "complete this task manager").complete
  #     allow(Time).to receive(:now).and_return(Time.parse("3PM"))
  #     task2 = TM::Task.new(1, 2, "complete this task manager like now").complete
  #     allow(Time).to receive(:now).and_return(Time.parse("5PM"))
  #     task3 = TM::Task.new(1, 2, "complete this task manager YESTERDAY")

  #     project.task << task3
  #     project.task << task2
  #     project.task << task1

  #     expect(project.completed_task).to eq([task1, task2])
  #   end

  #   it 'list incompleted task in order by priority' do
  #     allow(Time).to receive(:now).and_return(Time.parse("12PM"))
  #     task1 = TM::Task.new(1, 3, "complete this task manager")
  #     allow(Time).to receive(:now).and_return(Time.parse("3PM"))
  #     task2 = TM::Task.new(1, 2, "complete this task manager like now")
  #     allow(Time).to receive(:now).and_return(Time.parse("5PM"))
  #     task3 = TM::Task.new(1, 1, "complete this task manager YESTERDAY")

  #     project.task << task1
  #     project.task << task2
  #     project.task << task3

  #     expect(project.incompleted_task).to eq([task3, task2, task1])
  #   end

  #   it 'list over_due task first' do
  #     allow(Time).to receive(:now).and_return(Time.parse("12PM"))
  #     task1 = TM::Task.new(1, 3, "complete this task manager")
  #     allow(Time).to receive(:now).and_return(Time.parse("3PM"))
  #     task2 = TM::Task.new(1, 2, "complete this task manager like now")
  #     allow(Time).to receive(:now).and_return(Time.parse("5PM"))
  #     task3 = TM::Task.new(1, 1, "complete this task manager YESTERDAY")

  #     project.task << task1
  #     project.task << task2
  #     project.task << task3
  #   end

  #   it 'list incompleted task in order by priority and oldest first' do
  #     task2 = TM::Task.new(1, 2, "complete this task manager Today")
  #     allow(Time).to receive(:now).and_return(Time.at(0))
  #     task1 = TM::Task.new(1, 2, "complete this task manager")

  #     project.task << task1
  #     project.task << task2

  #     allow(Time).to receive(:now).and_return(Time.new)

  #     expect(project.incompleted_task).to eq([task1, task2])
  #   end
  # end

  # context "A new task can be added" do
  #   let(:project) { TM::Project.new("My_first_project") }

  #   it "can add a new task" do
  #     project.add_task(1, 1, "Add a new task already!")

  #     expect(project.task.count).to eq(1)
  #   end
  # end


end
