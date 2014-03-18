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

end
