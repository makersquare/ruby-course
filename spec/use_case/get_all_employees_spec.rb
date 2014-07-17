require 'spec_helper.rb'
describe TM::GetAllEmployees do
  before do
    @db = TM.db
    @project = @db.create_project("Test")
  end

  it "returns an error if no employees exist" do
    result = subject.run({})
    expect(result.error?).to eq(true)
    expect(result.error).to eq(:no_employees_exist)
  end

  it "lists all projects" do
    employee1 = @db.create_employee("Bob")
    employee2 = @db.create_employee("Stephen")

    result = subject.run({})
    expect(result.success?).to eq(true)
    expect(result.employees[1].name).to eq("Stephen")

  end
end
