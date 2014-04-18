require_relative '../spec_helper.rb'

describe Timeline::CreateEvent do
  before do
    @db = Timeline.db
  end

  it "I want to create an Event that is associated with a team" do
    team1 = @db.create_team :name => 'Sungod'
    user1 = @db.create_user(:user=> "Bob")
    event = @db.create_event(:team_id => team1.id)
    expect(event.team_id).to eq(team1.id)
    result = subject.run({:name =>team1.name, :team_id=>team1.id, :user_id =>user1.id})
    expect(result.success?).to eq true
    expect(result.event.team_id).to eq (team1.id)
    @db.clear_everything
  end

  it "Will throw an error when creating an Event, if that associated team does not exists" do
    # event = @db.create_event(:name => "Funtime",:team_id => team2.id)
    result = subject.run({:name => "Funtime", :team_id =>15})
    expect(result.error?).to eq true
    expect(result.error).to eq :no_team_with_that_id
  end

  it "It ensures the user exists" do
    user1 = @db.create_user(:user=> "Bob")
    team1 = @db.create_team(:name =>"cool team")
    event = @db.create_event(:team_id => team1.id)
    result = subject.run({:name =>team1.name, :team_id=>team1.id, :user_id =>user1.id})
    @db.clear_everything
  end

  it "throws an error if the user does not exists" do
    team1 = @db.create_team(:name =>"cool team")
    event = @db.create_event(:team_id => team1.id)
    result = subject.run({:name =>team1.name, :team_id=>team1.id, :user_id =>67})
    expect(result.error?).to eq true
    @db.clear_everything
  end

  it "throws an error if the event has an invalid name" do
    team1 = @db.create_team(:name =>"")
    user1 = @db.create_user(:user=> "Bob")
    event = @db.create_event(:team_id => team1.id)
    result = subject.run({:name =>team1.name, :team_id=>team1.id, :user_id =>user1.id})
    expect(result.error?).to eq true
    @db.clear_everything
  end

end


