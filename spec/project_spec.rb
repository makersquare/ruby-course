require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end
  it "contains classwide population variable used for PID assignment, starting at 0" do
    expect(TM::Project.task_nums).to eql(0)
  end
  describe "#initialize" do
    let(:proj) { TM::Project.new("project name") }

    it "throws errors if initialized without a name" do
      expect{TM::Project.new}.to raise_exception(ArgumentError)
    end
    it "initializes with a publicaly readable name" do
      expect(proj.name).to eql("project name")
    end



  end
end
