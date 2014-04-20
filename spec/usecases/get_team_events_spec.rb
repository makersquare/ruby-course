require 'spec_helper'

describe "Timeline::GetTeamEvents" do
  before do
    @db = Timeline.db
    @user = @db.create_user(:name => "parth")
    @team = @db.create_team(:name => "wizards")
    @event = @db.create_event(:user_id => @user.id, :team_id => @team.id, :name => "event", :content => "this is great", :tags => ['a', 'b'] )
    @event2 = @db.create_event(:user_id => @user.id, :team_id => @team.id, :name => "event", :content => "this is great", :tags => ['a', 'b'] )
  end

  it "is a class" do
     expect(Timeline::GetTeamEvents).to be_a(Class)
  end

  it "correct returns an error" do
    result = Timeline::GetTeamEvents.run(:name => "blue")
    expect(result.error).to eq(:no_team_id)
  end

  it "works with correct inputs" do
    result = Timeline::GetTeamEvents.run(:team_id => @team.id)
    expect(result.events.count).to eq(2)
  end
end
