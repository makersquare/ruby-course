require 'spec_helper'

describe Honker::CreateHonk do

  before do
    @user = Honker::User.new(77, "bob", "pass_digest")
  end

  it "requires the user to be signed in" do
    # Stub the database to return nil; we're testing this TxS, not the database code
    expect(Honker.db).to receive(:get_user_by_session_id).and_return(nil)

    result = Honker::CreateHonk.run(:session_id => "doesn't matter", :content => "nope")
    expect(result[:success?]).to eq false
    expect(result[:error]).to eq :not_signed_in
  end

  it "requires content to be present" do
    # Stub the database methods; we're testing this TxS, not the database code
    expect(Honker.db).to receive(:get_user_by_session_id).and_return(@user)

    result = Honker::CreateHonk.run(:session_id => "doesn't matter", :content => "")
    expect(result[:success?]).to eq false
    expect(result[:error]).to eq :invalid_content
  end

  it "creates a honk" do
    # Stub databases methods; we're testing this TxS, not the database code
    expect(Honker.db).to receive(:get_user_by_session_id).and_return(@user)
    expect(Honker.db).to receive(:persist_honk)

    result = Honker::CreateHonk.run(:session_id => "doesn't matter", :content => "hi")
    expect(result[:success?]).to eq true

    honk = result[:honk]
    expect(honk).to be_a Honker::Honk
    expect(honk.user_id).to eq @user.id
    expect(honk.content).to eq "hi"
  end

end
