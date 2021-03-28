class MapsController < ApplicationController

  def new
    @map = Map.new
  end

  def create
    @map = Map.new(map_params)

    if @map.save
      @map_tile_type = Map::TILE_TERRAIN_SELECTION
      render :map_tile_setup
    else
      flash.now.alert = @map.first_error_message
      render :new
    end
  end

  def update
    @map = Map.find(params[:id])
    user_selections = params[:map] || {}

    if user_selections[:type] == Map::TILE_TERRAIN_SELECTION
      @map.create_tile_terrain_from_user_input(user_selections)
      @map_tile_type = Map::TILE_EXIT_SELECTION
      render :map_tile_setup

    elsif user_selections[:type] == Map::TILE_EXIT_SELECTION
      @map.create_exit_tile_from_user_input(user_selections)

      if @map.exit_tile
        render :map_occupant_setup
      else
        flash.now.alert = 'Select a single exit'
        @map_tile_type = Map::TILE_EXIT_SELECTION
        render :map_tile_setup
      end

    else
      error = @map.create_starting_character_from_user_input(
        starting_character_params,
        starting_character_position_params
      )
      if error
        flash.now.alert = error
        render :map_occupant_setup
        return
      end

      error = @map.create_starting_enemy_from_user_input(
        starting_enemy1_params,
        starting_enemy1_position_params
      )
      if error
        flash.now.alert = error
        render :map_occupant_setup
        return
      end

      error = @map.create_starting_enemy_from_user_input(
        starting_enemy2_params,
        starting_enemy2_position_params
      ) if starting_enemy2_submitted?
      if error
        flash.now.alert = error
        render :map_occupant_setup
        return
      end

      redirect_to :root
    end
  end

  def destroy
    @map = Map.find(params[:id])
    @map.destroy!
    redirect_to :root
  end

  private

  def map_params
    params.require(:map).permit(:name, :length, :height)
  end

  def starting_character_params
    params.require(:starting_character).permit(:health, :actions, :attack, :defense)
  end

  def starting_character_position_params
    params.require(:starting_character).permit(:row, :column)
  end

  def starting_enemy1_params
    params.require(:starting_enemy1).permit(:health, :actions, :attack, :defense)
  end

  def starting_enemy1_position_params
    params.require(:starting_enemy1).permit(:row, :column)
  end

  def starting_enemy2_params
    params.require(:starting_enemy2).permit(:health, :actions, :attack, :defense)
  end

  def starting_enemy2_position_params
    params.require(:starting_enemy2).permit(:row, :column)
  end

  def starting_enemy2_submitted?
    starting_enemy2_params.values.all?(&:present?) &&
    starting_enemy2_position_params.values.all?(&:present?)
  end
end
