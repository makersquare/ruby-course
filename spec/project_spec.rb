require 'spec_helper'

describe 'Project' do
  before(:each) do
    @p1 = TM::Project.new("My First Project")
    @p2 = TM::Project.new("My Second Project")
    TM::Project.reset_class_variables
  end
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe ".initialize" do
    it "creates a new project with name" do
      expect(@p1.name).to eq("My First Project")
    end

    it "automatically assigns a project ID to new project" do
      expect(@p1.id).to eq(1)
      expect(@p2.id).to eq(2)
    end
  end
end
