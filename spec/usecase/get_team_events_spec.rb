require_relative '../spec_helper.rb'

describe Timeline::GetTeamEvents do
  before do
    @db = Timeline.db
  end

  it "should return all events for a given team" do
    team = @db.create_team(:name => "good team")
    event1 = @db.create_event(:name =>"waterpark", :team_id=>team.id)
    event2 = @db.create_event(:name=>"southbywest",:team_id=>team.id)
    event3 = @db.create_event(:name=>"hackathon",:team_id=>team.id)

  end

end
