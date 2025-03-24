class VinyardsController < ApplicationController
  def index
    @vinyards = Vinyard.all
  end

  def show
    @vinyard = Vinyard.find(params[:id])
    @dividendes = @vinyard.dividendes.current_year
    @dividende = @vinyard.dividendes.current_year.first
    @bottles = @dividende.dividende_cuvee_colors
    @appellations = @dividende.vinyard_appellations
    @users = Box.where(dividende_id: @dividende.id, exchangeable: true).includes(:user).map(&:user).uniq

  end


end
