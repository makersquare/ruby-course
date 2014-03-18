require 'spec_helper'

describe 'Project' do

  before do
    @my_proj = TM::Project.new "To Do"
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  xit "initializes with name and id" do
      expect(@my_proj.name).to eq("To Do")
      expect(@my_proj.id).to eq(0)
  end

  it "can add new tasks to the project and return num tasks" do
    result = @my_proj.add_task("buy milk", 5)
    expect(result).to eq(1)
  end
end
