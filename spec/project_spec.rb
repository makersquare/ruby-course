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

  describe '#complete_tasks' do
    it 'lists all complete tasks' do
      task = double("task")
      task2 = double("task2")
      task3 = double("task3")

      #give each task an id
      allow(task).to receive(:id).and_return(0)
      allow(task2).to receive(:id).and_return(1)
      allow(task3).to receive(:id).and_return(2)
      #set task and task3 to have matching project id's
      allow(task).to receive(:project_id).and_return(0)
      allow(task2).to receive(:project_id).and_return(1)
      allow(task3).to receive(:project_id).and_return(0)
      # set task and task3 created_at times for sorting
      allow(task).to receive(:created_at).and_return(Time.now)
      allow(task3).to receive(:created_at).and_return(Time.new(1992))

      allow(TM::Task).to receive(:tasks).and_return({task.id => task, task2.id => task2, task3.id => task3})

      expect(project.complete_tasks).to eq([task3, task])
    end
  end
end
