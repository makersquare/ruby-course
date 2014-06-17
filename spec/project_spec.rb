require 'spec_helper'

describe 'Project' do
  RSpec::Mocks::setup(self)
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  before(:each) do
    TM::Project.destroy_all_projects(true)
  end

  describe "#initialize" do
    it "initlaizes with a name given and necessary attributes" do
      proj = TM::Project.new("proj name")
      expect(proj.name).to eql("proj name")
    end
  end
  describe "#add_task" do
    it "can add a task to its own project_tasks list" do
      proj1 = TM::Project.new("proj1")
      expect(proj1.project_tasks.count).to eql(0)
      proj1.add_task("tast1", 5)
      expect(proj1.project_tasks.count).to eql(1)
    end
  end
  describe ".get_project" do
    it "can retrieve a project given the pid from it project repository" do
      proj1 = TM::Project.new("proj1")
      proj2 = TM::Project.new("proj2")
      should_be_proj2 = TM::Project.get_project(1)
      expect(should_be_proj2).to eql(proj2)
    end
  end

  describe "#completed_tasks" do
    proj = TM::Project.new("test")
    proj.add_task("test1", "desc", 4)
    sleep(1000)
    proj.add_task("test2", "desc", 6)
    sleep(1000)
    proj.add_task("test3", "desc", 4)
    sleep(1000)
    proj.add_task("test4", "desc", 2)
    sleep(1000)
    proj.add_task("test5", "desc", 8)

    # Test this method
  end

  describe "#incomplete_tasks" do
    # TODO
    # Test this method
  end

end
