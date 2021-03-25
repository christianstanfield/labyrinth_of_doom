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
      redirect_to @game, notice: 'Escape if you can'
    else
      redirect_to :new_game, notice: @game.first_error_message
    end
  end

  def show
    @game       = Game.find(params[:id])
    @map_tiles  = @game.map.map_tiles
    @characters = Character.for_game(@game).includes(:map_position)
    @deceased_characters = @game.deceased_characters.includes(:map_position)
    @enemies    = Enemy.for_game(@game).includes(:map_position)
  end

  def update
    @game = Game.find(params[:id])
    single_player_character = @game.single_player_character

    if character_move
      single_player_character.move(character_move)
    elsif character_attacking?
      attack_result = single_player_character.attack_enemy
      flash.notice = attack_result if attack_result
    elsif character_defending?
      single_player_character.defend
      flash.notice = 'You defended'
    end

    if single_player_character.errors.present?
      flash.alert = single_player_character.first_error_message
    end

    if @game.successful?
      flash.notice = 'Congratulations! You escaped with your life'
    else
      @game.enemies_turn(single_player_character)
    end

    if @game.over?
      flash.alert = 'You died. Game over'
    end

    redirect_to @game
  end

  private

  def game_params
    params.require(:game).permit(:map_id)
  end

  def character_move
    params.require(:game).permit(:move)[:move]
  end

  def character_attacking?
    params.require(:game).permit(:attack)[:attack] == 'true'
  end

  def character_defending?
    params.require(:game).permit(:defend)[:defend] == 'true'
  end
end
