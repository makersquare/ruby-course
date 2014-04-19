require 'spec_helper'

describe 'db' do
  before do
    Timeline.instance_variable_set(:@db_class, "")
  end

  it "is in memory by default" do
    db = Timeline.db
    expect(db).to be_a Timeline::Database::InMemory
  end

  it "can be configured to work with sql" do
    Timeline.config_db("sqlite3")
    db = Timeline.db
    expect(db).to be_a Timeline::Database::SQLite
  end
end
