class Songify::Song

  attr_reader :name, :album_id, :id, :embed

  def initialize(params)
    @name = params[:name]
    @album_id = params[:album_id].to_i
    @embed = params[:embed]
    @id = params[:id].to_i
  end
end