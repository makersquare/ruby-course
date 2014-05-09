require 'spec_helper'
require 'pry-debugger'

describe 'Project' do
  before(:each) do
    reset_class_variables(TM::Project)
    reset_class_variables(TM::Task)
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
      # expect(TM::Project.projects).to eq({project.id => project, project2.id => project2, project3.id => project3})
      expect(TM::Project.projects).to eq([project, project2, project3])
    end
  end

  describe '.add_project' do
    it 'adds a project to @@projects' do
      project = double("project")
      allow(project).to receive(:id).and_return(0)

      # expect(TM::Project.projects).to eq({})
      expect(TM::Project.projects).to eq([])
      TM::Project.add_project(project)
      # expect(TM::Project.projects).to eq({project.id => project})
      expect(TM::Project.projects).to eq([project])
    end
  end

  describe 'listing tasks' do

    before(:each) do
      @project = TM::Project.new("new project")
      @project2 = TM::Project.new("another project")
      @task = TM::Task.new(@project.id, "desc", 2)
      allow(Time).to receive(:now).and_return(Time.new(1996))
      @task2 = TM::Task.new(@project2.id, "desc", 3)
      allow(Time).to receive(:now).and_return(Time.new(1982))
      @task3 = TM::Task.new(@project.id, "desc", 3)
      allow(Time).to receive(:now).and_return(Time.new(1995))
      @task4 = TM::Task.new(@project.id, "desc", 2)
      allow(Time).to receive(:now).and_return(Time.new(1994))
      @task5 = TM::Task.new(@project.id, "desc", 1)
      allow(Time).to receive(:now).and_return(Time.new(1993))
      @task6 = TM::Task.new(@project.id, "desc", 1)
      @task.complete = false
      @task2.complete = true
      @task3.complete = false
      @task4.complete = true
      @task5.complete = false
      @task6.complete = true

      # allow(TM::Task).to receive(:tasks).and_return({task.id => task, task2.id => task2, task3.id => task3, task4.id => task4, task5.id => task5, task6.id => task6})
    end

    describe '#complete_tasks' do
      it 'lists all complete tasks sorted by created_at time' do
        expect(@project.complete_tasks).to eq([@task6, @task4])
      end
    end

    describe '#incomplete_tasks' do
      it 'lists incomplete tasks sorted by priority number' do
        # task: 2, task3: 3, task5: 1
        expect(@project.incomplete_tasks).to eq([@task5, @task, @task3])
      end

      context 'if two tasks have the same priority number' do


        before(:each) do
          allow(Time).to receive(:now).and_return(Time.new(1993))
          @task7 = TM::Task.new(@project.id, "desc", 2)
          # allow(TM::Task).to receive(:tasks).and_return({task.id => task, task2.id => task2, task3.id => task3, task4.id => task4, task5.id => task5, task6.id => task6, task7.id => task7})
        end

        it 'the older task comes first' do
          expect(@project.incomplete_tasks).to eq([@task5, @task7, @task, @task3])
        end
      end
    end
  end
end
