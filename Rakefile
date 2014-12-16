require_relative 'spec_helper.rb'

@album_repo = Songify::AlbumRepo.new
@song_repo = Songify::SongRepo.new

task :seed do 
  @album_repo.drop_table
  @song_repo.drop_table
  puts 'tables dropped'
  @album_repo.create_table
  @song_repo.create_table
  puts 'tables created'
  @album_repo.add_new_album(
        {title: 'Darkness on the Edge of Town',
        artist: 'Bruce Springsteen',
        cover: 'http://upload.wikimedia.org/wikipedia/en/a/af/BruceSpringsteenDarknessontheEdgeofTown.jpg'
        })
  @song_repo.add_new_song({
    name: 'Prove It All Night',
    album_id: 1,
    embed: "spotify:track:0Ye9OGxiHF3jylblTCuX7Q"
  })
  @song_repo.add_new_song({
    name: "Streets Of FIre",
    album_id: 1,
    embed: "spotify:track:1PuHLoIL9LTev7T5ONv5zI"
  })
  @song_repo.add_new_song({
    name: "Badlands",
    album_id: 1,
    embed: "spotify:track:0M1YQiRGel1tTMjA3orfRd"
  })
  puts 'seeded bruce'
  @album_repo.add_new_album(
    {title: 'Pet Sounds',
    artist: 'The Beach Boys',
    cover: 'http://upload.wikimedia.org/wikipedia/en/b/bb/PetSoundsCover.jpg'
    })
  @song_repo.add_new_song({
    name: 'Sloop John B',
    album_id: 2,
    embed: "spotify:track:2ULL3VZf4WwBKO4vjwT7Bg"
    })
  @song_repo.add_new_song({
    name: 'God Only Knows',
    album_id: 2,
    embed: "spotify:track:6iGU74CwXuT4XVepjc9Emf"
  })
  @song_repo.add_new_song({
    name: "Hang On To Your Ego",
    album_id: 2,
    embed: "spotify:track:4ZSBGLE9j9buk6DXVSryBI"
  })
  puts 'seeded the beach boys'
  @album_repo.add_new_album(
    {title: 'Run The Jewels 2',
    artist: 'Killer Mike & El P',
    cover: 'http://36.media.tumblr.com/4d1d4fa86923323f2686e9f8baacfd23/tumblr_ngbryfp3IH1t00btlo1_1280.jpg'
  })
  @song_repo.add_new_song({
    name: "Blockbuster Night Part 1",
    album_id: 3,
    embed: "spotify:track:2KxIMZDazuXN3yvPC6Kqwn"
  })
  @song_repo.add_new_song({
    name: "Crown",
    album_id: 3,
    embed: "spotify:track:43ZfXZ1rtlnIuhfwePQUwU"
  })
  @song_repo.add_new_song({
    name: "Lie, Cheat, Steal",
    album_id: 3,
    embed: "spotify:track:3UN6UkL6M0l8vfZS7OffZ6"
  })
  puts 'seeded RTJ2'
  @album_repo.add_new_album(
    {title: 'Quality Street',
    artist: 'Nick Lowe',
    cover: 'http://ecx.images-amazon.com/images/I/91ZdT8CmwiL._SX425_.jpg'
    })
  @song_repo.add_new_song({
    name: "Christmas At The Airport",
    album_id: 4,
    embed: "spotify:track:2bcAQKVDXBSp8NJumciMlC"
  })
  @song_repo.add_new_song({
    name: "Old Toy Trains",
    album_id: 4,
    embed: "spotify:track:6XewVgajWGBcCYZ3LRM1Vu"
  })
  @song_repo.add_new_song({
    name: "I Wish It Could Be Christmas Every Day",
    album_id: 4,
    embed: "spotify:track:4Evc12lXqVVcyb5XzMVUpa"
  })
  puts 'seeded Quality Street'
  @album_repo.add_new_album({
    title: 'Summerteeth',
    artist: 'Wilco',
    cover: 'http://ecx.images-amazon.com/images/I/51bJzaovu7L.jpg'
  })
  @song_repo.add_new_song({
    name: "How To Fight Loneliness",
    album_id: 5,
    embed: "spotify:track:1CsMuJeMzRqNgS7G0fo1Gv"
  })
  @song_repo.add_new_song({
    name: "Via Chicago",
    album_id: 5,
    embed: "spotify:track:58nPDufBVhMa2bT8G59CzS"
  })
  @song_repo.add_new_song({
    name: "When you Wake Up Feeling Old",
    album_id: 5,
    embed: "spotify:track:2cc0vgUmSTfWCIxfmdD2uS"
  })
  puts 'seeded Wilco'
end