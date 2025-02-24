class VinyardsController < ApplicationController
  def index
    @vinyards = Vinyard.all

  end

  def show
    @vinyard = Vinyard.find(params[:id])
  end
end
