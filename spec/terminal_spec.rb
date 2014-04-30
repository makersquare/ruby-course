require 'spec_helper'
require 'pry'

describe 'TerminalClient' do
  it "exists" do
    expect(TM::TerminalClient).to be_a(Class)
  end

  context 'a terminal client is initialized' do
    let(:terminal) { TM::TerminalClient.new }

    it 'has an array for projects' do
      expect(terminal.projects).to eq([])
    end
  end

  context 'a new project is created' do
    let(:terminal) { TM::TerminalClient.new }
    let(:project1) { TM::Project.new("Project 1") }
    let(:project2) { TM::Project.new("Project 2") }

    it 'can create a new project' do
      terminal.create_project("Project 1")
      expect(terminal.projects.count).to eq(1)
    end

    it 'can list all current projects' do
      terminal.projects << project1
      terminal.projects << project2

      expect(terminal.list_projects).to eq([project1, project2])
    end
  end

  context 'a project is created and task are viewed' do
    let(:terminal) { TM::TerminalClient.new }
    let(:project1) { TM::Project.new("Project 1") }
    let(:project2) { TM::Project.new("Project 2") }
    let(:task1) { TM::Task.new(3, 1, "complete this task manager") }
    let(:task2) { TM::Task.new(3, 2, "complete this task manager") }

    it 'can list all remaining task for a project by project ID' do
      terminal.projects << project1
      terminal.projects << project2
      project1.task << task1
      project1.task << task2

      expect(terminal.remaining_task(3)).to eq([task1,task2])
    end

    it 'can list all previously completed task' do
      terminal.projects << project1
      terminal.projects << project2
      project1.task << task1.complete
      project1.task << task2

      expect(terminal.history(5)).to eq([task1])
    end
  end

  context 'a task is added to a current project' do
    let(:terminal) { TM::TerminalClient.new }
    let(:project1) { TM::Project.new("Project 1") }

    it "increases the project's task count by 1" do
      terminal.projects << project1
      expect(terminal.projects.first.task.count).to eq(0)
      terminal.add_task(7,3, "Add a task already!")
      expect(terminal.projects.first.task.count).to eq(1)
    end

  end
end
