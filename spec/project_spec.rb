require 'spec_helper'
require 'pry'

describe 'Project' do
  before(:each) do
    reset_class_variables(TM::Project)
  end

  let(:project) { TM::Project.new('Moving') }

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe '.initialize' do
    it "requires a name" do
      expect { TM::Project.new }.to raise_error(ArgumentError)
      expect { project }.not_to raise_error
    end

    it "assigns a unique id" do
      expect(project.id).to eq(0)
      expect(TM::Project.new('Second').id).to eq(1)
    end
  end

  describe '.generate_id' do
    it 'generates a unique id' do
      expect(TM::Project.generate_id).to eq(0)
      expect(TM::Project.generate_id).to eq(1)
      expect(TM::Project.generate_id).to eq(2)
    end
  end

  describe '.projects' do
    it 'returns an array of all the projects created' do
      project
      project2 = TM::Project.new("what")
      project3 = TM::Project.new("is this")
      expect(TM::Project.projects).to eq({project.id => project, project2.id => project2, project3.id => project3})
    end
  end

  describe '.add_project' do
    it 'adds a project to @@projects' do
      project = double("project")
      allow(project).to receive(:id).and_return(0)

      expect(TM::Project.projects).to eq({})
      TM::Project.add_project(project)
      expect(TM::Project.projects).to eq({project.id => project})
    end
  end

  describe 'listing tasks' do

    let(:task) { double("task") }
    let(:task2) { double("task2") }
    let(:task3) { double("task3") }
    let(:task4) { double("task4") }
    let(:task5) { double("task5") }
    let(:task6) { double("task6") }


    before(:each) do
      allow(task).to receive(:id).and_return(0)
      allow(task2).to receive(:id).and_return(1)
      allow(task3).to receive(:id).and_return(2)
      allow(task4).to receive(:id).and_return(3)
      allow(task5).to receive(:id).and_return(4)
      allow(task6).to receive(:id).and_return(5)

      allow(task).to receive(:complete?).and_return(false)
      allow(task2).to receive(:complete?).and_return(true)
      allow(task3).to receive(:complete?).and_return(false)
      allow(task4).to receive(:complete?).and_return(true)
      allow(task5).to receive(:complete?).and_return(false)
      allow(task6).to receive(:complete?).and_return(true)
      #set matching project id's
      allow(task).to receive(:project_id).and_return(0)
      allow(task2).to receive(:project_id).and_return(1)
      allow(task3).to receive(:project_id).and_return(0)
      allow(task4).to receive(:project_id).and_return(0)
      allow(task5).to receive(:project_id).and_return(0)
      allow(task6).to receive(:project_id).and_return(0)
      # set created_at times for sorting
      allow(task).to receive(:created_at).and_return(Time.now)
      allow(task2).to receive(:created_at).and_return(Time.new(1996))
      allow(task3).to receive(:created_at).and_return(Time.new(1982))
      allow(task4).to receive(:created_at).and_return(Time.new(1995))
      allow(task5).to receive(:created_at).and_return(Time.new(1994))
      allow(task6).to receive(:created_at).and_return(Time.new(1993))
      # set priority_numbers
      allow(task).to receive(:priority_number).and_return(2)
      allow(task2).to receive(:priority_number).and_return(3)
      allow(task3).to receive(:priority_number).and_return(3)
      allow(task4).to receive(:priority_number).and_return(2)
      allow(task5).to receive(:priority_number).and_return(1)
      allow(task6).to receive(:priority_number).and_return(1)

      allow(TM::Task).to receive(:tasks).and_return({task.id => task, task2.id => task2, task3.id => task3, task4.id => task4, task5.id => task5, task6.id => task6})
    end

    describe '#complete_tasks' do
      it 'lists all complete tasks sorted by created_at time' do
        expect(project.complete_tasks).to eq([task6, task4])
      end
    end

    describe '#incomplete_tasks' do
      it 'lists incomplete tasks sorted by priority number' do
        # task: 2, task3: 3, task5: 1
        expect(project.incomplete_tasks).to eq([task5, task, task3])
      end

      context 'if two tasks have the same priority number' do
        let(:task7) { double("task7") }

        before(:each) do
          allow(task7).to receive(:id).and_return(6)
          allow(task7).to receive(:complete?).and_return(false)
          allow(task7).to receive(:project_id).and_return(0)
          allow(task7).to receive(:created_at).and_return(Time.new(1949))
          allow(task7).to receive(:priority_number).and_return(2)

          allow(TM::Task).to receive(:tasks).and_return({task.id => task, task2.id => task2, task3.id => task3, task4.id => task4, task5.id => task5, task6.id => task6, task7.id => task7})
        end

        it 'the older task comes first' do
          expect(project.incomplete_tasks).to eq([task5, task7, task, task3])
        end
      end
    end
  end
end
