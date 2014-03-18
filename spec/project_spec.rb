require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  before do
    TM::Project.current_id = 1
    @kill_bob = TM::Project.new("Kill Bob")
    @kill_sue = TM::Project.new("Kill Sue")
  end

  it "is created with a name" do
    expect(@kill_bob.name).to eq("Kill Bob")
  end

  it "automtically assigns a new id" do
    expect(@kill_bob.id).to eq(1)
    expect(@kill_sue.id).to eq(2)
  end

end
