require 'spec_helper'

describe 'Project' do

  let(:p1) { TM::Project.new("Project 1", 1)}
  let(:p2) { TM::Project.new("Project 2", 2)}

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe '#initialze' do
    it "allows a new project to be created with a name" do
        expect(p1.name).to eq("Project 1")
        expect(p1.pid).to eq(1)

        expect(p2.name).to eq("Project 2")
        expect(p2.pid).to eq(2)
    end
  end

end
