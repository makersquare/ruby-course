require './spec/spec_helper.rb'

describe Timeline::CreateEvent do

  let(:user) { Timeline.db.create_user(name: "Drew") }
  let(:team) { Timeline.db.create_team(name: "Dream Team") }
  let(:name) { "Event X" }

  it "returns error if user does not exist" do
    result = subject.run({ user_id: 6000, team_id: team.id, name: name })
    
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:invalid_user)
  end

  it "returns error if team does not exist" do
    result = subject.run({ user_id: user.id, team_id: 6000, name: name })

    expect(result.success?).to eq(false)
    expect(result.error).to eq(:invalid_team)
  end

  it "returns error if name is blank" do
    result = subject.run({ user_id: user.id, team_id: team.id, name: "" })

    expect(result.success?).to eq(false)
    expect(result.error).to eq(:invalid_name)
  end

  it "creates an event with the correct arguments" do
    result = subject.run({ user_id: user.id, team_id: team.id, name: name })
    
    expect(result.success?).to eq(true)
    expect(result.event).to be_a Timeline::Event
    expect(result.event.user_id).to eq(user.id)
    expect(result.event.team_id).to eq(team.id)
    expect(result.event.name).to eq(name)
  end
end