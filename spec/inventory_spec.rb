require_relative 'spec_helper.rb'
require 'pg'



describe PuppyBreeder::Repos::Inventory do

  before do
    PuppyBreeder.request_repo.refresh_tables
    PuppyBreeder.puppy_repo.refresh_tables
  end

  #there must be a better way to test for this
  #creates a puppy, adds the puppy, retrieves the log, checks to see
  #if log is empty (should return false indicating log has the puppy)
  it 'creates a new inventory' do
    pup = PuppyBreeder::Puppy.new("Dana", "Schnauzer", 5)
    PuppyBreeder.puppy_repo.add_puppy(pup)
    test = PuppyBreeder.puppy_repo.log

    expect(test.empty?).to be_false
  end

  it 'adds a puppy to the inventory' do
    #this tests the log method, add_puppy method, and the build puppy method
    #maybe I'm supposed to test those individually but all I'm doing is 
    #modifying my previous tests. 
    puppy = PuppyBreeder::Puppy.new("Dana", "Schnauzer", 1)
    PuppyBreeder.puppy_repo.add_puppy(puppy)
    list = PuppyBreeder.puppy_repo.log
    expect(list.last.name).to eq(puppy.name)
  end
end