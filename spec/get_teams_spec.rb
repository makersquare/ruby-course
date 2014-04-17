require 'spec_helper'

describe Timeline::GetTeams do
  before do
    @db = Timeline.db
    @team1 = @db.create_team({name: "Astros"})
    @team2 = @db.create_team({name: "Brewers"})
    @team3 = @db.create_team({name: "Cardinals"})
   end

  it "returns all teams in database" do
    result = subject.run()
    expect(result.teams.last.name).to eq "Cardinals"
  end
end
