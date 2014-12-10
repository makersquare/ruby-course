class Songify::Album

  attr_reader :title, :artist, :cover

  def initialize(params)
    @title = params[:title]
    @artist = params[:artist]
    @cover = params[:cover]
  end

end