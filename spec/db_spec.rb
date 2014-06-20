require 'spec_helper'
require 'pry-byebug'

describe 'TM::DB' do

  before(:all) do
    @conn = PG.connect(host: 'localhost', dbname: 'task-manager-test')
    @db = TM::DB.new
    @db.send(:db=, @conn)
  end

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
    before(:all) do
      @conn.exec('TRUNCATE TABLE employees RESTART IDENTITY CASCADE')
    end

    # it ".create_employee accepts an argument hash and returns the created employee" do
    # it ".get_employee accepts an id and returns the employee" do
    # it ".update_employee accepts an id and args hash and returns the updated employee" do
    # it ".delete_employee accepts an id and returns the deleted employee" do

    it ".create_employee accepts an argument hash and returns the created employee" do
      args = {'name' => 'Sam', 'email' => 'sam@email.com'}
      result = @db.create_employee(args)
      expect( result ).to be_a(TM::Employee)
      expect(result.id).to be_a(Integer)
    end

    it ".get_employee accepts an id and returns the employee" do
      employee = @db.create_employee( {'name' => 'Joe', 'email' => 'joe@email.com'} )
      result = @db.get_employee(employee.id)
      expect( result ).to be_a(TM::Employee)
      expect(result.id).to eq(employee.id)
      expect(result.name).to eq(employee.name)
    end

    it ".update_employee accepts an id and args hash and returns the updated employee" do
      employee = @db.create_employee( {'name' => 'Joe', 'email' => 'joe@email.com'} )

      args = {'name' => 'Bill'}
      result = @db.update_employee(employee.id, args)
      expect( result ).to be_a(TM::Employee)
      expect(result.id).to eq(employee.id)
      expect(result.name).to eq("Bill")
      expect(result.email).to eq("joe@email.com")
    end

    it ".delete_employee accepts an id and returns the deleted employee" do
      employee = @db.create_employee( {'name' => 'Joe', 'email' => 'joe@email.com'} )

      result = @db.delete_employee(employee.id)
      expect( result ).to be_a(TM::Employee)
      expect(result.id).to eq(employee.id)
      expect(result.email).to eq("joe@email.com")
    end
  end

  # context "Projects" do
  #   before(:all) do
  #     @conn.exec('TRUNCATE TABLE projects RESTART IDENTITY CASCADE')
  #   end

  #   it ".create_project accepts an argument hash and returns the created project" do
  #     args = {'name' => 'Test Project', 'completed' => false}
  #     result = @db.create_project(args)
  #     expect( result ).to be_a(TM::Employee)
  #     expect(result.id).to be_a(Integer)
  #   end

  #   it ".get_employee accepts an id and returns the employee" do
  #     employee = @db.create_employee( {'name' => 'Joe', 'email' => 'joe@email.com'} )
  #     result = @db.get_employee(employee.id)
  #     expect( result ).to be_a(TM::Employee)
  #     expect(result.id).to eq(employee.id)
  #     expect(result.name).to eq(employee.name)
  #   end

  #   it ".update_employee accepts an id and args hash and returns the updated employee" do
  #     employee = @db.create_employee( {'name' => 'Joe', 'email' => 'joe@email.com'} )

  #     args = {'name' => 'Bill'}
  #     result = @db.update_employee(employee.id, args)
  #     expect( result ).to be_a(TM::Employee)
  #     expect(result.id).to eq(employee.id)
  #     expect(result.name).to eq("Bill")
  #     expect(result.email).to eq("joe@email.com")
  #   end

  #   it ".delete_employee accepts an id and returns the deleted employee" do
  #     employee = @db.create_employee( {'name' => 'Joe', 'email' => 'joe@email.com'} )

  #     result = @db.delete_employee(employee.id)
  #     expect( result ).to be_a(TM::Employee)
  #     expect(result.id).to eq(employee.id)
  #     expect(result.email).to eq("joe@email.com")
  #   end


  #   it ".create_project accepts an array and returns the created project attributes" do
  #     db = klass.new
  #     result = db.create_project(['Build Task Manager', false])
  #     expect( result ).to be_a(Hash)
  #     expect(result[:id]).to be_a(Integer)
  #     expect(result[:id]).to_be > 0
  #   end
  # end

  context "Tasks" do
    before(:all) do
      @conn.exec('TRUNCATE TABLE tasks RESTART IDENTITY CASCADE')
      @employee = @db.create_employee( {'name' => 'Joe', 'email' => 'joe@email.com'} )
      @project  = @db.create_project( {'name' => 'Write Code', 'completed' => false } )
    end

    it ".create_task accepts an argument hash and returns the created task" do
      # (priority, description, project_id, employee_id, completed)
      args = {'priority' => 1, 'description' => 'Test Task', 'project_id' => @project.id,
              'employee_id' => @employee.id, 'completed' => false}
      result = @db.create_task(args)
      expect( result ).to be_a(TM::Task)
      expect(result.id).to be_a(Integer)
      expect(result.project_id).to eq(@project.id)
      expect(result.employee_id).to eq(@employee.id)
      expect(result.created_at).to be_a(Time)
    end
  end
end
