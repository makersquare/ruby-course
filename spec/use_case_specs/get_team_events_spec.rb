require 'spec_helper'
describe Timeline::GetTeamEvents do
  before do
    @user = Timeline.db.create_user(name: "Brady")
    @team = Timeline.db.create_team(name: "Team_1")
    @event1 = Timeline.db.create_event(name: "Event1", user_id: @user.id, team_id: @team.id)
    @event2 = Timeline.db.create_event(name: "Event2", user_id: @user.id, team_id: @team.id)
  end

  it "returns a list of all events associated with a team" do
    result = subject.run(:team_id => @team.id)
    expect(result.success?).to eq(true)
    expect(result.events.length).to eq(2)
  end

  it "returns a failure 'invalid team id' if not a valid tid" do
    result = subject.run(:team_id => 9283498)
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:invalid_team_id)
  end
end
