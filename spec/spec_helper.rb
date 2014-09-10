
require_relative '../lib/songify.rb'

#Songify.song_repo = Songify::Repositories::Song_Repo.new

RSpec.configure do |config|
  config.before(:each) do
    Songify.song_repo.drop_table
  end
end