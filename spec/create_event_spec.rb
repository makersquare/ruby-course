require 'spec_helper'

describe Timeline::CreateEvent do
  before do
    @db = Timeline.db
    @user = @db.create_user({name: "Brian"})
    @team = @db.create_team({name: "Astros"})
  end

  it "can create a new event" do
    attrs = { user_id: @user.id, team_id: @team.id, name: "Fun Event" }
    result = subject.run(attrs)

    expect(result.success?).to eq true
    expect(result.event.user_id).to eq(attrs[:user_id])
    expect(result.event.team_id).to eq(attrs[:team_id])
    expect(result.event.name).to eq(attrs[:name])
  end

  it "returns an error if no user_id is specified" do
    attrs = { team_id: @team.id, name: "Fun Event" }
    result = subject.run(attrs)

    expect(result.error).to eq :user_id_not_specified
  end

  it "returns an error if no team_id is specified" do
    attrs = { user_id: @user.id, name: "Fun Event" }
    result = subject.run(attrs)
    expect(result.error).to eq :team_id_not_specified
  end

  it "returns an error if no name is specified" do
    attrs = { user_id: @user.id, team_id: @team.id }
    result = subject.run(attrs)
    expect(result.error).to eq :event_name_not_specified
  end
end
