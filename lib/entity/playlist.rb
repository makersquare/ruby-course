class Songify::Playlist

  attr_reader :id, :title

  def initialize(params)
    @id = params[:id].to_i
    @title = params[:title]
  end
end