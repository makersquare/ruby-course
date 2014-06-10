require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "stores all project instances in an array" do
    expect(Project.project_list).to be_an_instance_of(Array)
  end

  it "is initialized with a name, a unique ID, a default task list of 0, and adds itself to the project list array" do
    p = Project.new(name)
    expect(p.name).to eq(name)
    expect(p.id).to eq(Project.project_list.size)
    expect(p.task_list).to eq(0)

    p2 = Project.new(name2)
    expect(Project.project_list.size).to eq(2)
    expect(p2.id).to eq(2)
  end
end
