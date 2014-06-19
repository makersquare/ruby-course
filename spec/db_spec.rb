require 'spec_helper'

describe 'TM::DB' do

  let(:klass) { TM::DB }

  it "exists" do
    expect(klass).to be_a(Class)
  end

  it "TM module responds to db by returning the DB singleton class" do
    db = TM.db
    expect(TM.db).to eq(db)
  end

  it "responds to new by returning a new instance" do
    db = klass.new
    expect(klass.new).not_to eq(db)
  end

  context "Employees" do
    it ".create_employee accepts an argument hash and returns the created employee" do
      db = klass.new
      args = {'name' => 'Joe', 'email' => 'joe@email.com'}
      result = db.create_employee(args)
      expect( result ).to be_a(TM::Employee)
      expect(result.id).to be_a(Integer)
    end

    it ".get_employee accepts an id and returns the employee" do
      db = klass.new
      result = db.get_employee(1)
      expect( result ).to be_a(TM::Employee)
      expect(result.id).to eq(1)
    end

    it ".update_employee accepts an id and args hash and returns the updated employee" do
      db = klass.new
      args = {'name' => 'Sam'}
      result = db.update_employee(1, args)
      expect( result ).to be_a(TM::Employee)
      expect(result.id).to eq(1)
      expect(result.name).to eq("Sam")
      expect(result.email).to eq("joe@emai.com")
    end
  end

  # context "Projects" do
  #   it ".create_project accepts an array and returns the created project attributes" do
  #     db = klass.new
  #     result = db.create_project(['Build Task Manager', false])
  #     expect( result ).to be_a(Hash)
  #     expect(result[:id]).to be_a(Integer)
  #     expect(result[:id]).to_be > 0
  #   end
  # end

#   context "Tasks" do
#     # before(:all) do
#     #   @employee = TM::Employee.new('Tester', 'tester@email.com').create
#     #   @project = TM::Project.new('Test Proj').create
#     # end

#     it ".create_task accepts an array and returns the created task attributes" do
#       db = klass.new
#       employee_id = db.create_employee(['Joe','joe@email.com'])
#       project_id  = db.create_project(['Build Task Manager', false])
# puts employee_id
# puts project_id

#       # (priority, description, project_id, employee_id, completed)
#       task = db.create_task([1, 'Test Task', project_id, employee_id, false])
#       expect(task).to be_a(Hash)
#       expect(task[:id]).to to_a(Integer)
#       expect(task[:project_id]).to eq(@project.id)
#       expect(task[:employee_id]).to eq(@employee.id)
#       expect(task[:created_at]).to be_a(Time)
#     end
#   end
end
