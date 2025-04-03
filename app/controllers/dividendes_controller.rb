class DividendesController < ApplicationController

  def index
    @dividendes = Dividende.current_year
  end

  def show

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

  def edit
    @dividende = Dividende.find(params[:id])
    @vinyard = @dividende.vinyard
    @cuvee_colors = @vinyard.cuvee_colors
    render 'dividendes/edit'
  end

  def update
    @dividende = Dividende.find(params[:id])
    @vinyard = @dividende.vinyard
    @cuvee_colors = @vinyard.cuvee_colors
    @dividende.update(dividende_params)
    if @dividende.save
      redirect_to vinyard_path(@vinyard)
    else
      render 'dividendes/edit'
    end
  end

  def destroy
    @dividende = Dividende.find(params[:id])
    @vinyard = @dividende.vinyard
    @dividende.destroy
    redirect_to vinyard_path(@vinyard)
  end

  


private

  def dividende_params
    params.require(:dividende).permit(:vinyard_id, :year, :shipping_date, :value, dividende_cuvee_colors_attributes: [:cuvee_color_id, :bottle_quantity, :id, :_destroy])
  end
end
