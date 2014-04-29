require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "creates an empty array at initalization" do
    new_project = TM::Project.new
    expect(new_project.project).to eq([])
  end

end
