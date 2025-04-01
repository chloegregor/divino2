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
    @cuvee_colors = @vinyard.cuvee_colors
    @dividende = Dividende.new
    @dividende.dividende_cuvee_colors.build
    render 'dividendes/new_dividende'
  end

  def create
    @vinyard = Vinyard.find(params[:vinyard_id])
    @cuvee_colors = @vinyard.cuvee_colors
    @dividende = Dividende.new(dividende_params)
    @dividende.vinyard = @vinyard
    if @dividende.save
      redirect_to vinyard_path(@vinyard)
    else
      puts @dividende.errors.full_messages
      render 'dividendes/new_dividende'
    end
  end

private

  def dividende_params
    params.require(:dividende).permit(:vinyard_id, :year, :shipping_date, :value, dividende_cuvee_colors_attributes: [:cuvee_color_id, :bottle_quantity])
  end
end
