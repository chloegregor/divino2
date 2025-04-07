class SlotsController < ApplicationController
  def new
    @vinyard = Vinyard.find(params[:vinyard_id])
    @slot = Slot.new
    render 'slots/new'
  end
end
