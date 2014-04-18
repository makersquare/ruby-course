describe Timeline::CreateEvent do
  before do

    @user = @db.create_user("wendy")
    @team = @db.create_team("rockets")

  end
  xit "errors if the user id is missing" do
    # binding.pry
    result = Timeline::CreateEvent.run(:user_id => 345)

    expect(result.error?).to eq(true)
    expect(result.error).to eq(:missing_uid)
  end

  xit "errors, if user does not exist"do
  result = Timeline::CreateEvent.run()
  result = RPS::CreateInvite.run(:session_key =>@session.key, :invitee_id => "123")
  expect(result.error).to eq(:user_missing)
  end

  xit "passes and creates an invite"do
  result = RPS::CreateInvite.run(:session_key =>@session.key, :invitee_id => @wendy.id)
  expect(result.success?).to eq(true)
  end
end
