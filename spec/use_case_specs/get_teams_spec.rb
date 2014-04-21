require 'spec_helper'
describe Timeline::GetTeams do
  before do
    @team1 = Timeline.db.create_team(name: "Team_1")
    @team2 = Timeline.db.create_team(name: "Team_2")
    @team3 = Timeline.db.create_team(name: "Team_3")
  end

  it "returns a list of all teams" do
    result = subject.run
    expect(result.success?).to eq(true)
    expect(result.teams.length).to eq(3)
  end
end
