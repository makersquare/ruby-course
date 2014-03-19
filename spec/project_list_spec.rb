require 'spec_helper'

describe 'Project list' do

  before do
    @proj_list = TM::Project_list.new
  end

it "can create a project" do
  result = @proj_list.create_project("Cure cancer") # PROJ 1
  expect(result).to be_a(Array)
  expect(result[0]).to be_a(TM::Project)
  expect(result[0].id).to eq(1)
  expect(result[0].name).to eq("Cure cancer")
end

it "can list all projects" do
  @proj_list.create_project("Solve world hunger") #PROJ 2
  @proj_list.create_project("Build a warship") #PROJ 3
  result = @proj_list.create_project("Clone Einstein") #PROJ 4
  expect(result[1].name).to eq("Solve world hunger")
  expect(result[3].name).to eq("Clone Einstein")
  expect(result[3].id).to eq(4)
end

end
