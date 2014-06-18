require 'spec_helper'

describe 'TM::DB' do

  let(:klass) { TM::DB }

  it "exists" do
    expect(klass).to be_a(Class)
  end

  it "it responds to db by returning the singleton class" do
    db = klass.new
    expect(klass.db).to eq(db)
  end

  it "responds to new by returning a new instance" do
    db = klass.new
    expect(klass.new).not_to eq(db)
  end

  context "Tasks" do
    it ".create_task accepts an array and returns the created task attributes" do
      db = klass.new
      # priority, description, project_id, employee_id, completed
      # args = {id: 1, priority: 1, description: 'description', project_id: 2, employee_id: 3, completed: false, created_at: Time.now}
      expect(db.create_task([1, 'description', 2, 3, false])).to be_at(Hash)
      expect(db.create_task([1, 'description', 2, 3, false])[:id]).to eq(1)
    end
  end
end
