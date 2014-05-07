require 'spec_helper'
require 'pry-debugger'

describe 'ProjectManager' do
  before(:each) do
    TM::Project.reset_class_variables
    TM::Task.reset_class_variables
    @pm = TM::ProjectManager.new
    @project1 = TM::Project.new("Grades")
    @project2 = TM::Project.new("Tests")
  end
  describe 'initialize' do
    it "initializes with an empty array for projects" do
      expect(@pm.projects.length).to eq(0)
    end
  end

  describe 'methods' do
    before (:each) do
      @pm.add_project(@project1)
      @pm.add_project(@project2)
    end

    describe 'add_project' do
      it "adds a project to the @projects array" do
        expect(@pm.projects.first).to eq(@project1)
      end
    end

    describe 'get_project' do
      it "returns the project that matches the given id" do
        expect(@pm.get_project(2)).to eq(@project2)
      end

      it "returns nil if given a project id that doesn't match any project" do
        expect(@pm.get_project(5)).to eq(nil)
      end
    end

    describe 'list all' do
      it "lists all projects" do
          task = TM::Task.new("Create gradebook", @project1.id, 1)
          task2 = TM::Task.new("Add students", @project1.id, 2)
          task3 = TM::Task.new("Create gradebook", @project2.id, 1)
          task4 = TM::Task.new("Add students", @project2.id, 2)

          @project1.add_task(task)
          @project1.add_task(task2)
          @project2.add_task(task3)
          @project2.add_task(task4)

          task.due_date = "1 Feb 2014"
          task2.due_date = "1 June 2012"
          task3.due_date = "3 Feb 2015"
          task4.due_date = "1 May 2020"

          TM::Task.mark_complete(1)
          STDOUT.should_receive(:puts).with("Name: Grades - ID: 1")
          STDOUT.should_receive(:puts).with("Percentage Finished - 50.0%")
          STDOUT.should_receive(:puts).with("Percentage Tasks Overdue - 50.0%")
          STDOUT.should_receive(:puts).with("Name: Tests - ID: 2")
          STDOUT.should_receive(:puts).with("Percentage Finished - 0%")
          STDOUT.should_receive(:puts).with("Percentage Tasks Overdue - 0%")
          @pm.list_all
        end
    end
  end
end
