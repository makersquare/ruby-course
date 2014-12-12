class Songify::Album

  attr_reader :title, :artist, :cover, :id

  def initialize(params)
    @title = params[:title]
    @artist = params[:artist]
    @cover = params[:cover]
    @id = params[:id].to_i
  end

end