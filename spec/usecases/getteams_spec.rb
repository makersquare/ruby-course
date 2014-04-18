describe Timeline::GetTeams do


  it "errors, if team is missing" do
    # teams = Timeline.db_all_teams
    result = subject.run()
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:missing_team)
  end

  it "returns success" do
    team = Timeline.db.create_team(name: "rockets")
    # team2 = Timeline.db.create_team(name: "winners")
    # teams = Timeline.db.all_teams
    result = subject.run()
    expect(result.success?).to eq(true)

    # expect(result.team).to eq([team, team2])
    # expect(result)

  end

end
