describe Timeline::CreateEvent do
  before do

    @user = Timeline.db.create_user(name: "wendy")
    @team = Timeline.db.create_team(name: "rockets")

  end
  it "errors if the user is missing" do
    result = subject.run({user_id: 12})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:missing_user)
  end

  it "errors, if team is missing" do
    result = subject.run({user_id: @user.id, team_id: 123})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:missing_team)
  end

  it "returns success" do
    Timeline.db.create_event({user_id: @user.id, team_id:@team.id, name:"Waterfall", content:"lots of water", tags:"fun"})
    result = subject.run({user_id: @user.id, team_id: @team.id, name: "Waterfall", content: "lots of water", tags:"fun"})
    expect(result.success?).to eq(true)
    expect(result.event.user_id).to eq(@user.id)

  end
end
