describe Timeline::GetTeams do
  before do
    Timeline.db.clear_everything
  end

  it "errors, if team is missing" do

    result = subject.run()
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:missing_team)
  end

  it "returns success" do

    team = Timeline.db.create_team(name: "rockets")
    result = subject.run()
    expect(result.success?).to eq(true)
    expect(result.teams.count).to eq(1)

  end

end
