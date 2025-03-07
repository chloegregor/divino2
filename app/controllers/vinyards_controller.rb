class VinyardsController < ApplicationController
  def index
    @vinyards = Vinyard.all
  end

  def show
    @vinyard = Vinyard.find(params[:id])
    @dividendes = @vinyard.dividendes.current_year
  end
end
