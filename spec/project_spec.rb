require 'spec_helper'

describe 'Project' do

  let(:p1) {TM::Project.new("p1", 0)}
  let(:p2) {TM::Project.new("p2", 1)}

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "initializes with a name and id" do
    expect(p1).to be_a(TM::Project)
    expect(p1.name).to eq("p1")
    expect(p1.id).to eq(0)
  end

end
