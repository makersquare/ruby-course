require 'spec_helper'

describe 'Project' do

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "initializes with name and id" do
      a_proj = TM::Project.new "Weekend Errands"
      expect(a_proj.name).to eq("Weekend Errands")
      expect(a_proj.id).to be_a(Integer)
  end

end
