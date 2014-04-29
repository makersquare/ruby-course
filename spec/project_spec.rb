require 'spec_helper'

describe 'Project' do

  before do
    TM::Project.reset_id_count
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "initializes with a name" do
    result = TM::Project.new("My Project")
    expect(result).to be_a(TM::Project)
    expect(result.name).to eq("My Project")
  end

  it "initializes with a unique id" do
    p1 = TM::Project.new("p1")
    p2 = TM::Project.new("p2")
    expect(p1.id).to eq(1)
    expect(p2.id).to eq(2)
  end
end
