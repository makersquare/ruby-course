require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it 'can create a new project with a name' do
    classy = TM::Project.new('ClassyLady')

    expect(classy.name).to eq('ClassyLady')
  end

  it 'must austomatically generate and assign the new project a unique id' do
    classy = TM::Project.new('ClassyLady')

    expect(classy.id).to_not be_nil
  end
end


# This must automatically generate and assign the new project a unique id (you can use a class variable for this)

# A new task can be created with a project id, description, and priority number

# A task can be marked as complete, specified by id

# A project can retrieve a list of all complete tasks, sorted by creation date

# A project can retrieve a list of all incomplete tasks, sorted by priority

# If two tasks have the same priority number, the older task gets priority
