require_relative '../spec_helper.rb'

describe 'Add Employee' do
  before do
    @db = TM::DB.instance
  end

  it "exists" do
    expect(TM::AddEmployee).to be_a(Class)
  end

  xit "creates and adds an employee to the DB" do
    emp = TM::AddEmployee.run('Bob')

    expect(emp).to be_a(TM::Employee)
    expect(@db.employees.first).to be(emp)
  end
end