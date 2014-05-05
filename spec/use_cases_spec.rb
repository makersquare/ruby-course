require 'spec_helper.rb'

describe 'Use Cases' do

  let(:db) { Timeline.db }

  before { db.clear_everything }

  describe 'GetTeams' do
    it "returns all teams" do
      team1 = db.create_team :name => 'Tigers'
      team2 = db.create_team :name => 'Pirates'
    
      result = Timeline::GetTeams.run
    
      expect(result.success?).to be_true
      expect(result.teams.count).to eq 2
    end  
  end
  
  describe 'GetTeamEvents' do
    it "returns all events of a team" do
      team = db.create_team :name => 'Tigers'
      user = db.create_user :name => 'Brian'
      event1 = db.create_event(
        :name => 'home game',
        :created_at => Time.now,
        :user_id => user.id,
        :team_id => team.id,
        :tags => ['winning']
      )      
      event2 = db.create_event(
        :name => 'away game',
        :created_at => Time.now,
        :user_id => user.id,
        :team_id => team.id,
        :tags => ['losing']
      )
      
      result = Timeline::GetTeamEvents.run :team_id => team.id
    
      expect(result.success?).to be_true
      expect(result.events.count).to eq 2
    end
  end
  
  describe 'CreateEvent' do
    it "creates a event" do
      team = db.create_team :name => 'Tigers'
      user = db.create_user :name => 'Brian'
      
      result = Timeline::CreateEvent.run(
        :name => 'home game',
        :created_at => Time.now,
        :user_id => user.id,
        :team_id => team.id,
        :tags => ['winning', 'pwned']
      )
      
      expect(result.success?).to be_true
      expect(result.event.name).to eq 'home game'
    end
  end
end
