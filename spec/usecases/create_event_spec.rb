require './spec/spec_helper.rb'

describe Timeline::CreateEvent do
  before do
    @db = Timeline.db
    @user = @db.create_user("Drew")
    @team = @db.create_team("Dream Team")
    @name = "Hello"
  end

  it "returns error if user does not exist" do
    result = subject.run({ :user_id => 6000, :team_id => @team.id, :name => @name})
    expect(result.success?).to eq(false)
    expect(result.success).to eq(:user_not_found)
  end

  it "returns error if team does not exist" do
    result = subject.run({ :user_id => @user.id, :team_id => 6000, :name => @name})
    expect(result.success?).to eq(false)
    expect(result.success).to eq(:team_not_found)
  end

  it "returns error if name is blank" do
    result = subject.run({ :user_id => @user.id, :team_id => @team.id, :name => ""})
    expect(result.success?).to eq(false)
    expect(result.success).to eq(:invalid_name)
  end

  it "creates an event with the correct arguments" do
    result = subject.run({ :user_id => @user.id, :team_id => @team.id, :name => @name})
    event = @db.get_event(result.id)
    expect(result.success?).to eq(true)
    expect(event.user_id).to eq(@user.id)
    expect(event.team_id).to eq(@team.id)
  end
end