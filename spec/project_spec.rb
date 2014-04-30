require 'spec_helper'

describe 'Project' do
  before(:each) do
    TM::Project.reset_class_variables
    @p1 = TM::Project.new"p1"
    @p2 = TM::Project.new"p2"
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it 'can create a new project with a name' do
    expect(@p1.name).to eq('p1')
  end

  it 'must austomatically generate and assign the new project a unique id' do
    expect(@p1.id).to eq(1)
    expect(@p2.id).to eq(2)
  end

  it 'can add a task with a project id' do
    new = TM::Task.new("name", "description", 2)
    @p1.add_task(new)

    expect(new.project_id).to eq(1)
  end

end

# A project can retrieve a list of all complete tasks, sorted by creation date

# A project can retrieve a list of all incomplete tasks, sorted by priority

# If two tasks have the same priority number, the older task gets priority
