require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  let(:project1) {TM::Project.new("Portfolio")}
  let(:project2) {TM::Project.new("Website")}

  describe '#initialize' do
    it "is a Project" do
      expect(project1).to be_a(TM::Project)
    end
    it "creates a unique project id" do
      expect(project1.project_id.to_s.length).to eq(9)
      expect(project2.project_id).not_to eq(project1.project_id)
    end
    it "accepts a name argument" do
      expect(project1.name).to eq("Portfolio")
    end
    it "creates an array to store tasks" do
      expect(project1.tasks).to be_a(Array)
    end
    it "the array is empty" do
      expect(project1.tasks.count).to eq(0)
    end
  end

  describe '#add_task' do
    it "adds a task to the tasks array" do
      wireframe = TM::Task.new("Design a wireframe", 5, 123456789)
      project1.add_task(wireframe)
      binding.pry

      expect(project1.tasks.count).to eq(1)
    end
  end

  describe '#list_complete' do
    it "returns list of tasks sorted by creation date"
  end

  describe '#list_incomplete' do
    it "returns a list of incomplete tasks sorted by priority"
  end

end
