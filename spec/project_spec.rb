require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "should be initialized with a name" do
  	project = TM::Project.new("SXSW")
  	expect(project.name).to eq 'SXSW'
  end
end
