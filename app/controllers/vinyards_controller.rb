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
    @cuvee_colors_by_appellation = @vinyard.cuvees

  end

  def edit
    @vinyard = Vinyard.find(params[:id])
    render 'vinyards/edit_description'
  end

  def update
    @vinyard = Vinyard.find(params[:id])
    @vinyard.update(vinyard_params)
    redirect_to vinyard_path(@vinyard)
  end

  private

  def vinyard_params
    params.require(:vinyard).permit(:description)
  end

end
