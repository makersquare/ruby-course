require 'spec_helper'
describe Timeline::CreateEvent do
  before do
    @user = Timeline.db.create_user(name: "Brady")
    @team = Timeline.db.create_team(name: "Team_1")
  end

  it "creates an event" do
    result = subject.run(:name => "Event_1", :user_id => @user.id, :team_id => @team.id)
    expect(result.success?).to eq(true)
    expect(result.event.name).to eq("Event_1")
  end

  it "errors if the event  is created without a name" do
    result = subject.run(:user_id => @user.id, :team_id => @team.id)
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:no_name_given)
  end

  it "errors if the event is created without a valid user_id" do
    result = subject.run(:user_id => 69, :team_id => @team.id, :name => "Event_1")
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:invalid_user_id)
  end

  it "errors if the event is created without a valid team_id" do
    result = subject.run(:user_id => @user.id, :team_id => 80085, :name => "Event_1")
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:invalid_team_id)
  end
end
