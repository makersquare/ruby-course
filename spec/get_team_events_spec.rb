require 'spec_helper'

describe Timeline::GetTeamEvents do
  before do
    # Timeline.instance_variable_set(:@db_class, " ")
    @db = Timeline.db
    @team = @db.create_team({name: "Astros"})
    @user = @db.create_user({name: "Brian"})
    @event1 = @db.create_event({user_id: @user.id, team_id: @team.id, name: "Fun event"})
    @event2 = @db.create_event({user_id: @user.id, team_id: @team.id, name: "Cool event"})
    @event3 = @db.create_event({user_id: @user.id, team_id: @team.id, name: "Another event"})
  end

  it "returns all events for a team" do
    result = subject.run({team_id: @team.id})
    expect(result.success?).to eq true
    expect(result.events.first.id).to eq @event1.id
    expect(result.events.count).to eq 3
  end

  it "returns an error if team does not exist" do
    result = subject.run({team_id: 9999})
    expect(result.error).to eq :team_does_not_exist
  end
end
