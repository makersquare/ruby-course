
module Songify
  def self.songsrepo=(repo)
    @songsrepo = repo
  end

  def self.songsrepo
    @songsrepo
  end
end
require 'pry-byebug'
require_relative 'songify/entities/song.rb'
require_relative 'songify/repos/zrepo.rb'
require_relative 'songify/repos/songsrepo.rb'

Songify.songsrepo = Songify::Repos::Songs.new