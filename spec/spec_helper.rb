require_relative '../lib/songify.rb'
Songify.songs_repo = Songify::Repositories::Songs.new

RSpec.configure do |config|
  config.before(:each) do
    Songify.songs_repo.drop_table
  end
end

