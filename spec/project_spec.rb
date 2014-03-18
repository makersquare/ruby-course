require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end



  it "A new task can be created with a project id, description, and priority number" do

    newproject = TM::Project.new("MakerSquare", 3)
    expect(newproject.description).to eq ("MakerSquare")
    expect(newproject.priority_number).to eq (3)
    expect(TM::Project.id).to eq (1)

  end

end
