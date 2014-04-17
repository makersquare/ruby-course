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
    result = subject.run(:team_id => team.id)
    expect(result.success?).to eq true
    expect(result.event.length).to eq 3
  end

  it "should return an error if a team does not exist" do
    result = subject.run(:team_id => 56)
    expect(result.error?).to eq true
    expect(result.error).to eq :no_team_with_that_id
  end

end


 # it "I want to create an Event that is associated with a team" do
 #    team1 = @db.create_team :name => 'Sungod'

 #    event = @db.create_event(:team_id => team1.id)
 #    expect(event.team_id).to eq(team1.id)
 #    result = subject.run({:name =>team1.name, :team_id=>team1.id})
 #    expect(result.success?).to eq true
 #    expect(result.event.team_id).to eq (team1.id)
 #  end

 #  it "Will throw an error when creating an Event, if that associated team does not exists" do
 #    # event = @db.create_event(:name => "Funtime",:team_id => team2.id)
 #    result = subject.run({:name => "Funtime", :team_id =>15})
 #    expect(result.error?).to eq true
 #    expect(result.error).to eq :no_team_with_that_id
 #  end
