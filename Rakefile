require_relative 'spec_helper.rb'

@album_repo = Songify::AlbumRepo.new

task :seed do 
  @album_repo.drop_table
  puts 'table dropped'
  @album_repo.create_table
  puts 'table created'
  @album_repo.add_new_album(
        {title: 'Darkness on the Edge of Town',
        artist: 'Bruce Springsteen',
        cover: 'http://upload.wikimedia.org/wikipedia/en/a/af/BruceSpringsteenDarknessontheEdgeofTown.jpg'
        })
  puts 'seeding bruce'
      @album_repo.add_new_album(
        {title: 'Pet Sounds',
        artist: 'The Beach Boys',
        cover: 'http://upload.wikimedia.org/wikipedia/en/b/bb/PetSoundsCover.jpg'
        })
  puts 'seeding the beach boys'
      @album_repo.add_new_album(
        {title: 'Run The Jewels 2',
        artist: 'Killer Mike & El P',
        cover: 'http://36.media.tumblr.com/4d1d4fa86923323f2686e9f8baacfd23/tumblr_ngbryfp3IH1t00btlo1_1280.jpg'
        })
  puts 'seeding RTJ2'
      @album_repo.add_new_album(
        {title: 'Quality Street',
        artist: 'Nick Lowe',
        cover: 'http://ecx.images-amazon.com/images/I/91ZdT8CmwiL._SX425_.jpg'
        })
  puts 'seeding chrimbo'
      @album_repo.add_new_album({
        title: 'Summerteeth',
        artist: 'Wilco',
        cover: 'http://ecx.images-amazon.com/images/I/51bJzaovu7L.jpg'
        })
  puts 'seeding Wilco'
end