require_relative '../spec_helper.rb'

describe Timeline::CreateEvent do
  before do
    @db = Timeline.db
  end

  it "I want to create an Event that is associated with a team" do
    team1 = @db.create_team :name => 'Sungod'

    event = @db.create_event(:team_id => team1.id)
    expect(event.team_id).to eq(team1.id)
    result = subject.run({:name =>team1.name, :team_id=>team1.id})
    expect(result.success?).to eq true
    expect(result.event.team_id).to eq (team1.id)
  end

  it "Will throw an error when creating an Event, if that associated team does not exists" do
    # event = @db.create_event(:name => "Funtime",:team_id => team2.id)
    result = subject.run({:name => "Funtime", :team_id =>15})
    expect(result.error?).to eq true
    expect(result.error).to eq :no_team_with_that_id
  end

end


# it "signs up a user, with a name and password" do
#     user1 = @db.sign_up_user("bob","123")

#     #@db.sign_in_user("bob","123")

#     result = subject.run({:accname => "bob", :password =>"123"})
#     expect(result.success?).to eq true
#     expect(result.user.accname).to eq "bob"


#   end

#   it "errors if the user does not exists" do
#     result = subject.run({:accname => "MJ", :password =>"Bulls"})
#     expect(result.error?).to eq true
#     expect(result.error).to eq :user_does_not_exist
#   end

# end
