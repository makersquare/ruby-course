require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "adds all project instances to an array" do
    expect(TM::Project.project_list).to be_an_instance_of(Array)
  end

  it "is initialized with a name, a unique ID, a default task list of 0, and adds itself to the project list array" do
    p = TM::Project.new("Odin")
    expect(p.name).to eq("Odin")
    expect(p.id).to eq(TM::Project.project_list.size)
    expect(p.task_list.size).to eq(0)

    p2 = TM::Project.new("Euler")
    expect(TM::Project.project_list.size).to eq(2)
    expect(p2.id).to eq(2)
    expect(p2.task_list.size).to eq(0)
  end
end
