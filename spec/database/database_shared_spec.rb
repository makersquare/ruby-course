require 'spec_helper'

shared_examples_for "Database" do
  let(:db) { described_class.new }

  before { db.clear_all_records }

  describe 'Users' do
    it "creates a user" do
      user = db.create_user :name => 'Johnny'
      expect(user).to be_a Timeline::User
      expect(user.name).to eq 'Johnny'
      expect(user.id).to_not be_nil
    end

    it "gets a user" do
      user = db.create_user :name => 'Bob Bobber'
      retrieved_user = db.get_user(user.id)
      expect(retrieved_user.name).to eq 'Bob Bobber'
    end

    it "gets all users" do
      %w{Alice Bob}.each {|name| db.create_user :name => name }

      expect(db.all_users.count).to eq 2
      expect(db.all_users.map &:name).to include('Alice', 'Bob')
    end
  end


  describe 'Teams' do
    it "creates a team" do
      team = db.create_team :name => 'Ops'
      expect(team).to be_a Timeline::Team
      expect(team.name).to eq 'Ops'
      expect(team.id).to_not be_nil
    end

    it "gets a team" do
      team = db.create_team :name => 'Green'
      retrieved_team = db.get_team(team.id)
      expect(retrieved_team.name).to eq 'Green'
    end

    it "gets all teams" do
      %w{R G B}.each {|name| db.create_team :name => name }

      expect(db.all_teams.count).to eq 3
      expect(db.all_teams.map &:name).to include('R', 'G', 'B')
    end
  end


  describe 'Events' do
    it "creates an event" do
      event = db.create_event :name => 'Ping'
      expect(event).to be_a Timeline::Event
      expect(event.name).to eq 'Ping'
      expect(event.id).to_not be_nil
      expect(event.created_at).to be_a Time
    end

    it "gets an event" do
      event = db.create_event :name => 'Pong'
      retrieved_event = db.get_event(event.id)
      expect(retrieved_event.name).to eq 'Pong'
    end

    it "stores tags along with an event" do
      event = db.create_event :name => 'Doomsday', :tags => ['x', 'y', 'z']

      retrieved_event = db.get_event(event.id)
      expect(retrieved_event.name).to eq 'Doomsday'

      expect(retrieved_event.tags.count).to eq 3
      expect(retrieved_event.tags).to include('x', 'y', 'z')
    end
  end


  describe "Searching Events" do
    before do
      %w{Alice Bob}.each {|name| db.create_user :name => name }
      %w{Students Teachers}.each {|name| db.create_team :name => name }

      @alice = db.all_users.find {|user| user.name == 'Alice' }
      @students = db.all_teams.find {|team| team.name == 'Students' }
      @teachers = db.all_teams.find {|team| team.name == 'Teachers' }
    end

    it "queries events by team, ordered by creation date" do
      # Create event now
      db.create_event :name => 'x', :team_id => @students.id

      # Create event in the past
      Timecop.freeze(Time.now - 500) do
        db.create_event :name => 'y', :team_id => @students.id
      end

      # Create event in the future
      Timecop.freeze(Time.now + 500) do
        db.create_event :name => 'z', :team_id => @students.id
      end

      # Create unrelated event (shouldn't be counted)
      db.create_event :name => 'nope', :team_id => @teachers.id

      events = db.get_events_by_team(@students.id)
      expect(events.count).to eq 3
      expect(events.map &:name).to eq ['y', 'x', 'z']
    end
  end
end

describe InMemory do
  it_behaves_like "Database"
end

describe SQLiteDatabase do
  it_behaves_like "Database"
end