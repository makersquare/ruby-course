describe TM::DelegateEmployeeToProject do
  before do
    @database = TM.database
  end

  it "allows you to delegate an employee to a project" do
    # Set up our data
    result = subject.run({ :name => "parth" })
    expect(result.success?).to eq true
    expect(result.employee.name).to eq("parth")
  end

  it "gives you an error if employee or project does not exist" do
    # Set up our data
    result = subject.run({ :name => ''})
    expect(result.error?).to eq true
    expect(result.error).to eq (:employee_not_given_name)
  end
end
