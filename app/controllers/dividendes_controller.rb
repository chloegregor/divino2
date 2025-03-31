class DividendesController < ApplicationController

  def index
    @dividendes = Dividende.current_year
  end

  def show
    @dividende = Dividende.find(params[:id])
    @bottles = @dividende.dividende_cuvee_colors
    @appellations = @dividende.vinyard_appellations
    @users = Box.where(dividende_id: @dividende.id, exchangeable: true).includes(:user).map(&:user).uniq
  end

  def new
    @vinyard = Vinyard.find(params[:vinyard_id])
    render 'dividendes/new_dividende'
  end

end
