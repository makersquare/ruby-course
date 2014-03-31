describe TM::CreateProject do
  before do
    @database = TM.database
  end

  it "creates a project if string is given as name" do
    # Set up our data
    result = subject.run({ :name => "john" })
    expect(result.success?).to eq true
    expect(result.project.name).to eq("john")
  end

  it "errors if the task does not exist" do
    # Set up our data
    result = subject.run({ :name => '' })
    expect(result.error?).to eq true
    expect(result.error).to eq :project_name_not_given
  end
end
