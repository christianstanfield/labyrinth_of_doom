class GamesController < ApplicationController

  def index
  end

  def new
    @game = Game.new
    @maps = Map.all
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      @game.setup
      redirect_to @game
    else
      redirect_to :new_game, notice: @game.first_error_message
    end
  end

  def show
    @game       = Game.find(params[:id])
    @map_tiles  = @game.map.map_tiles
    @characters = Character.for_game(@game).includes(:map_position)
    @enemies    = Enemy.for_game(@game).includes(:map_position)
  end

  private

  def game_params
    params.require(:game).permit(:map_id)
  end
end
