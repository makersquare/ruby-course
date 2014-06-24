require 'spec_helper'
require 'pry-byebug'

describe 'TM::DB' do

  let(:dbname) { 'task-manager-test' }
  let(:db    ) { TM::DB.new(dbname)  }
  let(:klass ) { TM::DB }

  before(:all) do
    db.send(:conn).exec('TRUNCATE TABLE employees RESTART IDENTITY CASCADE')
  end

  it "exists" do
    expect(klass).to be_a(Class)
  end

  it "initialize accepts an optional argument for the database name" do
    expect( TM::DB.new(dbname).send(:conn).db ).to eq(dbname)
  end

  it "TM module responds to db by returning the DB singleton class" do
    db = TM.db
    expect(TM.db).to eq(db)
  end

  it "responds to new by returning a new instance" do
    db = klass.new
    expect(klass.new).not_to eq(db)
  end

  it "responds to 'create' given a table name as a string and args hash by returning the created object attributes" do
    result_array = db.create('employees', {'name' => 'Joe Smith'})
    expect(result_array).to be_a(Array)

    result = result_array.first
    expect(result).to be_a(Hash)
    expect(result[:id]).to be_a(Integer)
    expect(result[:name]).to eq('Joe Smith')
  end

  it "responds to 'find' given a table name as a string and args hash by returning the found object" do
    result_array = db.find('employees', {'id' => 1})
    expect(result_array).to be_a(Array)

    result = result_array.first
    expect(result).to be_a(Hash)
    expect(result[:id]).to be(1)
    expect(result[:name]).to eq('Joe Smith')
  end

  it "responds to 'update' given a table name as a string, id and args hash by returning the updated object" do
    result_array = db.update('employees', 1, {'name' => 'Bill Jones'})
    expect(result_array).to be_a(Array)

    result = result_array.first
    expect(result).to be_a(Hash)
    expect(result[:id]).to be(1)
    expect(result[:name]).to eq('Bill Jones')
  end

  it "responds to 'delete' given a table name as a string and id by returning the deleted object" do
    result_array = db.delete('employees', 1)
    expect(result_array).to be_a(Array)

    result = result_array.first
    expect(result).to be_a(Hash)
    expect(result[:id]).to be(1)
    expect(result[:name]).to eq('Bill Jones')
    expect(db.find('employees', {'id' => 1})).to eq([])
  end
end
