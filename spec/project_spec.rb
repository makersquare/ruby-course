require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "has a name" do
    test = TM::Project.new("Test")
    expect(test.name).to eq("Test")
  end

end
