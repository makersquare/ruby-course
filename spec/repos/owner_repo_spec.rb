require 'spec_helper'

describe PetShop::OwnerRepo do

  def owner_count
    repo.all(db).count
  end

  let(:repo) { PetShop::OwnerRepo }
  let(:db) { PetShop.create_db_connection('petshop_test') }

  before(:each) do
    PetShop.clear_db(db)
    @owner_id1 = PetShop::OwnerRepo.save(db, { 'username' => "Giovanni", 'password' => 'Swordfish' })['id']
    @owner_id2 = PetShop::OwnerRepo.save(db, { 'username' => "Leonardo", 'password' => 'Swordfish' })['id']
  end

  it "gets all owners" do

    owners = repo.all(db)
    expect(owners).to be_a Array
    expect(owners.count).to eq 2

    usernames = owners.map {|u| u['username'] }
    expect(usernames).to include "Leonardo", "Giovanni"
  end

  it "creates owners" do
    expect(owner_count).to eq 2

    owner = repo.save(db, { 'username' => "Brian", 'password' => 'puppyfan102' })
    expect(owner['id']).to_not be_nil
    expect(owner['username']).to eq "Brian"
    expect(owner['password']).to eq "puppyfan102"

    # Check for persistence
    expect(owner_count).to eq 3

    owner = repo.all(db).first
    expect(owner['id']).to_not be_nil
    expect(owner['username']).to eq "Giovanni"
    expect(owner['password']).to eq "Swordfish"

  end

  it "requires a username" do
    expect { repo.save(db, {}) }.to raise_error {|e|
      expect(e.message).to match /username/
    }
  end

  it "requires an owner id that exists" do
    expect {
      repo.save(db, { 'id' => 999, 'username' => "Mr FunGuy" })
    }
    .to raise_error {|e|
      expect(e.message).to match /owner id/
    }
  end

  it "finds owners" do
    retrieved_owner = repo.find(db, @owner_id1)
    expect(retrieved_owner['username']).to eq "Giovanni"
  end

  it "updates owners" do
    owner1 = repo.save(db, { 'id' => @owner_id1, 'username' => "Billy Boy" })
    owner2 = repo.save(db, { 'id' => @owner_id1, 'password' => "bigDogsRCool14" })
    expect(owner2['id']).to eq(owner1['id'])
    expect(owner2['password']).to eq "bigDogsRCool14"

    # Check for persistence
    owner3 = repo.find(db, owner1['id'])
    expect(owner3['username']).to eq "Billy Boy"
  end

end
