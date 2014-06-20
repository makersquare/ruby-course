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

    let(:sklass) { 'employees' }
    let(:klass ) { TM::Employee }
    let(:args  ) { {'name' => 'Sam', 'email' => 'sam@email.com'} }
    let(:update_args) { {'name' => 'Joe', 'email' => 'joe@email.com'} }

    it ".create accepts a klass as string and argument hash and returns the created object" do
      result = @db.create(sklass, args)
      expect( result  ).to be_a(klass)
      expect(result.id).to be_a(Integer)
    end

    it ".get accepts a klass as string and an id and returns the object" do
      object = @db.create(sklass, args)
      result = @db.get(sklass, object.id)
      expect( result  ).to be_a(klass)
      expect(result.id).to be_a(Integer)
      expect(result.id).to eq(object.id)
    end

    it ".update accepts a klass as string and an id and args hash and returns the updated object" do
      object = @db.create(sklass, args)
      result = @db.update(sklass, object.id, update_args)
      expect( result  ).to be_a(klass)
      expect(result.id).to be_a(Integer)
      expect(result.id).to eq(object.id)

      expect(result.name).to eq(update_args['name'])
      expect(result.email).to eq(update_args['email'])
    end

    it ".delete accepts a klass as string and an id and returns the deleted object" do
      object = @db.create(sklass, args)
      result = @db.delete(sklass, object.id)
      expect( result  ).to be_a(klass)
      expect(result.id).to be_a(Integer)
      expect(result.id).to eq(object.id)

      expect(@db.get(sklass, object.id)).to eq(nil)
    end
  end

  context "Projects" do
    before(:all) do
      @conn.exec('TRUNCATE TABLE projects RESTART IDENTITY CASCADE')
    end

    let(:sklass) { 'projects' }
    let(:klass ) { TM::Project }
    let(:args  ) { {'name' => 'Test Project', 'completed' => false} }
    let(:update_args) { {'name' => 'Project Test', 'completed' => true} }

    it ".create accepts a klass as string and argument hash and returns the created object" do
      result = @db.create(sklass, args)
      expect( result  ).to be_a(klass)
      expect(result.id).to be_a(Integer)
    end

    it ".get accepts a klass as string and an id and returns the object" do
      object = @db.create(sklass, args)
      result = @db.get(sklass, object.id)
      expect( result  ).to be_a(klass)
      expect(result.id).to be_a(Integer)
      expect(result.id).to eq(object.id)
    end

    it ".update accepts a klass as string and an id and args hash and returns the updated object" do
      object = @db.create(sklass, args)
      result = @db.update(sklass, object.id, update_args)
      expect( result  ).to be_a(klass)
      expect(result.id).to be_a(Integer)
      expect(result.id).to eq(object.id)

      expect(result.name).to eq(update_args['name'])
      expect(result.completed).to eq(update_args['completed'])
    end

    it ".delete accepts a klass as string and an id and returns the deleted object" do
      object = @db.create(sklass, args)
      result = @db.delete(sklass, object.id)
      expect( result  ).to be_a(klass)
      expect(result.id).to be_a(Integer)
      expect(result.id).to eq(object.id)

      expect(@db.get(sklass, object.id)).to eq(nil)
    end
  end

  context "Tasks" do
    before(:all) do
      @conn.exec('TRUNCATE TABLE tasks RESTART IDENTITY CASCADE')
      @employee = @db.create( 'employees', {'name' => 'Joe', 'email' => 'joe@email.com'} )
      @project  = @db.create( 'projects', {'name' => 'Write Code', 'completed' => false } )
    end

    let(:sklass) { 'tasks' }
    let(:klass ) { TM::Task }
    let(:args  ) {
      {'priority' => 1, 'description' => 'Test Task',
       'project_id' => @project.id, 'employee_id' => @employee.id,
       'completed' => false}
    }
    let(:update_args) {
      {'priority' => 3, 'description' => 'Task Test', 'completed' => true}
    }

    it ".create accepts a klass as string and argument hash and returns the created object" do
      result = @db.create(sklass, args)
      expect( result  ).to be_a(klass)
      expect(result.id).to be_a(Integer)

      expect(result.project_id).to eq(@project.id)
      expect(result.employee_id).to eq(@employee.id)
      expect(result.created_at).to be_a(Time)
    end

    it ".get accepts a klass as string and an id and returns the object" do
      object = @db.create(sklass, args)
      result = @db.get(sklass, object.id)
      expect( result  ).to be_a(klass)
      expect(result.id).to be_a(Integer)
      expect(result.id).to eq(object.id)
    end

    it ".update accepts a klass as string and an id and args hash and returns the updated object" do
      object = @db.create(sklass, args)
      result = @db.update(sklass, object.id, update_args)
      expect( result  ).to be_a(klass)
      expect(result.id).to be_a(Integer)
      expect(result.id).to eq(object.id)

      expect(result.description).to eq(update_args['description'])
      expect(result.completed).to eq(update_args['completed'])
    end

    it ".delete accepts a klass as string and an id and returns the deleted object" do
      object = @db.create(sklass, args)
      result = @db.delete(sklass, object.id)
      expect( result  ).to be_a(klass)
      expect(result.id).to be_a(Integer)
      expect(result.id).to eq(object.id)

      expect(@db.get(sklass, object.id)).to eq(nil)
    end
  end
end
