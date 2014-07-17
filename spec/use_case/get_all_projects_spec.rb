require 'spec_helper.rb'
describe TM::GetAllProjects do
  before do
    @db = TM.db
  end

  it "returns an error if no projects exist" do
    result = subject.run({})
    expect(result.error?).to eq(true)
    expect(result.error).to eq(:no_projects_exist)
  end

  it "lists all projects" do
    project1 = @db.create_project("hello")
    project2 = @db.create_project("hi")
    project3 = @db.create_project("how are you")

    result = subject.run({})
    expect(result.success?).to eq(true)
    expect(result.projects[2].name).to eq("how are you")

  end
end
