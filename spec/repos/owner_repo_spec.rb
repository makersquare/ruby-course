require 'spec_helper'

describe Petshop::OwnerRepo do

  def owner_count
    repo.all(db).count
  end

  let(:repo) { Petshop::OwnerRepo }
  let(:db) { Petshop.create_db_connection('petshop_test') }

  before(:each) do
    Petshop.clear_db(db)
    @owner_id1 = Petshop::OwnerRepo.save(db, { 'name' => "Giovanni", 'password' => 'Swordfish' })['id']
    @owner_id2 = Petshop::OwnerRepo.save(db, { 'name' => "Leonardo", 'password' => 'Swordfish' })['id']
  end

  xit "gets all owners" do

    owners = repo.all(db)
    expect(owners).to be_a Array
    expect(owners.count).to eq 2

    names = owners.map {|u| u['name'] }
    expect(names).to include "Leonardo", "Giovanni"
  end

  xit "creates owners" do
    expect(owner_count).to eq 2

    owner = repo.save(db, { 'name' => "Brian", 'password' => 'puppyfan102' })
    expect(owner['id']).to_not be_nil
    expect(owner['name']).to eq "Brian"
    expect(owner['password']).to eq "puppyfan102"

    # Check for persistence
    expect(owner_count).to eq 3

    owner = repo.all(db).first
    expect(owner['id']).to_not be_nil
    expect(owner['name']).to eq "Giovanni"
    expect(owner['password']).to eq "Swordfish"

  end

  xit "requires a name" do
    expect { repo.save(db, {}) }.to raise_error {|e|
      expect(e.message).to match /name/
    }
  end

  xit "requires an owner id that exists" do
    expect {
      repo.save(db, { 'id' => 999, 'name' => "Mr FunGuy" })
    }
    .to raise_error {|e|
      expect(e.message).to match /owner id/
    }
  end

  xit "finds owners" do
    retrieved_owner = repo.find(db, @owner_id1)
    expect(retrieved_owner['name']).to eq "Giovanni"
  end

  xit "updates owners" do
    owner1 = repo.save(db, { 'id' => @owner_id1, 'name' => "Billy Boy" })
    owner2 = repo.save(db, { 'id' => @owner_id1, 'password' => "bigDogsRCool14" })
    expect(owner2['id']).to eq(owner1['id'])
    expect(owner2['password']).to eq "bigDogsRCool14"

    # Check for persistence
    owner3 = repo.find(db, owner1['id'])
    expect(owner3['name']).to eq "Billy Boy"
  end

end
