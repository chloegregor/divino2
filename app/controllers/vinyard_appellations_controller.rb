class VinyardAppellationsController < ApplicationController

  def new
    @vinyard = Vinyard.find(params[:vinyard_id])
    render 'vinyard_appellations/new_vinyard_appellation'
  end

  def create
    @vinyard = Vinyard.find(params[:vinyard_id])
    @vinyard_appellation = VinyardAppellation.new(vinyard_appellation_params)
    @vinyard_appellation.vinyard = @vinyard
    if @vinyard_appellation.save
      redirect_to vinyard_path(@vinyard)
    else
      render 'vinyard_appellations/new_vinyard_appellation'
    end
  end

  def destroy
    @vinyard = Vinyard.find(params[:vinyard_id])
    @vinyard_appellation = VinyardAppellation.find(params[:id])
    @vinyard_appellation.destroy
    redirect_to vinyard_path(@vinyard)
  end

  private

  def vinyard_appellation_params
    params.require(:vinyard_appellation).permit(:vinyard_id, :appellation_id)
  end
end
