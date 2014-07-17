require_relative '../spec_helper.rb'

describe Timeline::GetTeams do
  before do

    @db = Timeline.db
    @db.clear_everything
  end

  it "should get all the teams" do
    team1 = @db.create_team(:name => "First team")
    team2 = @db.create_team(:name => "Second team")
    team3 = @db.create_team(:name => "Third team")
    teamlist = @db.all_teams
    expect(teamlist.length).to eq 3
    result = subject.run()
    expect(result.teams.length).to eq 3
    expect(result.success?).to eq true

  end



end
