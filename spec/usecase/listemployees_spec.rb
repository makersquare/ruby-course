describe TM::ListEmployees do
  before do
    @database = TM.database
  end

  it "checks for employees" do
    # Set up our data
    employee = @database.add_new_employee("parth")
    result = subject.run("yes")
    expect(result.success?).to eq true
    expect(result.employees[employee.id].name).to eq(employee.name)
  end

  it "errors if employees do not exist" do
    # Set up our data
    @database.employees = {}
    result = subject.run("yes")
    expect(result.error?).to eq true
    expect(result.error).to eq (:no_employees_found)
  end
end
