class DividendeCuveeColorsController < ApplicationController
  def new
    @dividende_cuvee_color = DividendeCuveeColor.new
    @vinyard = Vinyard.find(params[:vinyard_id])
    @cuvee_colors = @vinyard.cuvee_colors
    render 'dividende_cuvee_colors/new'
  end
end
