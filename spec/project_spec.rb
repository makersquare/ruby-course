require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe 'initialize' do
    it "creates a new project with a name" do
      project1 = TM::Project.new("Grades")

      expect(project1.name).to eq("Grades")
    end

    it "gives a new project a unique id" do
      project1 = TM::Project.new("Grades")
      expect(project1.id).to_not raise_error()
    end
  end
end
