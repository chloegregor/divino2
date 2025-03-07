class DividendesController < ApplicationController

  def index
    @dividendes = Dividende.current_year
  end

  def show
    @dividende = Dividende.find(params[:id])
    @bottles = @dividende.dividende_cuvee_colors
    @appellations = @dividende.vinyard_appellations
    @users = @dividende.users
  end

end
