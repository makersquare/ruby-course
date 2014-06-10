require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it 'initializes with a name and id' do
    project1 = TM::Project.new("project1")
    expect(project1.name).to eq("project1")
    expect(project1.id).to eq(1)

    project2 = TM::Project.new("project2")
    expect(project2.name).to eq("project2")
    expect(project2.id).to eq(2)
  end

  it 'sorts tasks by priority number' do
  end

  it 'sorts tasks by completion date' do
  end

  it 'retrieves a list of all completed tasks' do
  end

  it 'retrives a list of all incomplete tasks' do
  end

  it 'sorts the tasks in an incomplete list by priorty number' do
  end

  it 'sorts tasks in an incomplete list by creation date if the priority number is the same' do
  end

end



