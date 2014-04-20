require 'spec_helper'

describe "Timeline::CreateEvent" do
  before do
  @db = Timeline.db
  @user = @db.create_user(:name => "parth")
  @team = @db.create_team(:name => "wizards")
  @event = @db.create_event(:user_id => @user.id, :team_id => @team.id, :name => "event", :content => "this is great", :tags => ['a', 'b'] )
  end
  it "is a class" do
    expect(Timeline::CreateEvent).to be_a(Class)
  end

  it "returns the correct failures" do
    result = Timeline::CreateEvent.run(:team_id => 4, :user_id => 5)
    expect(result.error).to eq(:no_name_given)
    result = Timeline::CreateEvent.run(:name => 4, :user_id => 5)
    expect(result.error).to eq(:no_team_id)
    result = Timeline::CreateEvent.run(:name => 4, :team_id => 5)
    expect(result.error).to eq(:no_user_id)
    expect(@event.user_id).to eq(@user.id)
  end

  it "works with correct inputs" do
    result = Timeline::CreateEvent.run(:team_id => @team.id, :user_id => @user.id, :name => "good time")
    expect(result.event.name).to eq("good time")
  end
end
