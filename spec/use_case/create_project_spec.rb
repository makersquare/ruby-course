require 'spec_helper.rb'
describe TM::CreateProject do
  before do
    @db = TM.db
  end

  it "creates a project" do
    result = subject.run({ :name => "Test Project" })
    expect(result.success?).to eq(true)
    expect(result.project.name).to eq("Test Project")
  end

  it "returns an error if project name is empty string" do
    result = subject.run({ :name => "" })
    expect(result.error?).to eq(true)
    expect(result.error).to eq(:no_name_entered)
  end
end
