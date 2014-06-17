require 'spec_helper'

describe 'Project' do
  before(:each) do
    TM::Project.class_variable_set :@@projects, []
    TM::Project.class_variable_set :@@counter, 0
    @p1 = TM::Project.new "Paint"
    @p2 = TM::Project.new "Wash car"
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "must have a name" do
    expect(@p1.name).to eq "Paint"
  end

  it "has a project id" do
    expect(@p1.pid).to eq 1
  end

  it 'can retrieve a list of complete tasks' do
    TM::Task.new 1, 1, "Clean walls!!!!"
    TM::Task.new 2, 1, "Put down drop cloth!!!!"
    TM::Task.mark_complete 1
    TM::Task.mark_complete 2
    get_complete = TM::Project.get_complete_tasks 1
    expect(get_complete.size).to eq 2
  end

  it "can retrieve a list of incomplete tasks" do
    TM::Task.new 1,1,"Clean walls"
    TM::Task.new 2, 1, "Put down drop cloth"
    incomplete = TM::Project.get_incomplete_tasks 1
    expect(incomplete.size).to eq 2
  end

  it 'adds projects to an array' do
    projects = TM::Project.project_list
    expect(projects.size).to eq 2
  end
end
