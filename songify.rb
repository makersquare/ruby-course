module Songify
end

# require all lib/ entities and repos files here
require_relative 'lib/entity/album.rb'
require_relative 'lib/entity/song.rb'
require_relative 'lib/entity/playlist.rb'

require_relative 'lib/repo/repo.rb'
require_relative 'lib/repo/album_repo.rb'
require_relative 'lib/repo/song_repo.rb'
require_relative 'lib/repo/playlist_repo.rb'