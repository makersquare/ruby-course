describe TM::CreateEmployee do
  before do
    @database = TM.database
  end

  it "allows you to create an employee" do
    # Set up our data
    result = TM::CreateEmployee.run({ :name => "parth" })
    expect(result.success?).to eq true
    expect(result.employee.name).to eq("parth")
  end

  it "errors if the employee is not given a name" do
    # Set up our data
    result = TM::CreateEmployee.run({ :name => ''})
    expect(result.error?).to eq true
    expect(result.error).to eq (:employee_not_given_name)
  end
end
