describe 'Timeline.db' do
  it "uses Database::InMemory by default" do
    Timeline.setter("inMemory")
    expect(Timeline.db).to be_a(Timeline::Database::InMemory)
  end
  it "can configure to use a different database class" do
    Timeline.setter("persistence")
    expect(Timeline.db).to be_a(Timeline::Database::SQLiteDatabase)
  end
end
