class CuveeColorsController < ApplicationController

  def show
    @cuvee_color = CuveeColor.find(params[:id])
    @vinyard = Vinyard.find(params[:vinyard_id])
    @vinyard_appellation = VinyardAppellation.find(params[:vinyard_appellation_id])
    render "cuvee_colors/show"
  end

  def new
    @vinyard = Vinyard.find(params[:vinyard_id])
    @vinyard_appellation = VinyardAppellation.find(params[:vinyard_appellation_id])
    @cuvees = @vinyard_appellation.cuvees
    @cuvee_color = CuveeColor.new
    render "cuvee_colors/new"
  end

  def create
    @cuvee_color = CuveeColor.new(cuvee_color_params)
    @vinyard = @cuvee_color.cuvee.vinyard_appellation.vinyard
    @vinyard_appellation = @cuvee_color.cuvee.vinyard_appellation
    if @cuvee_color.save
      render "cuvee_colors/show"
    else
      render "cuvee_colors/new"
    end
  end

  def edit
    @cuvee_color = CuveeColor.find(params[:id])
    @vinyard = Vinyard.find(params[:vinyard_id])
    @vinyard_appellation = VinyardAppellation.find(params[:vinyard_appellation_id])
    render "cuvee_colors/edit"
  end

  def update
    @vinyard = Vinyard.find(params[:vinyard_id])
    @vinyard_appellation = VinyardAppellation.find(params[:vinyard_appellation_id])
    @cuvee_color = CuveeColor.find(params[:id])
    @cuvee_color.update(cuvee_color_params)
    if @cuvee_color.save
      render "cuvee_colors/show"
    else
      render "cuvee_colors/edit"
    end
  end

  def destroy
    @vinyard = Vinyard.find(params[:vinyard_id])
    @vinyard_appellation = VinyardAppellation.find(params[:vinyard_appellation_id])
    @cuvee_color = CuveeColor.find(params[:id])
    @cuvee_color.destroy
    redirect_to vinyard_path(@vinyard)
  end

  private

  def cuvee_color_params
    params.require(:cuvee_color).permit(:description, :color_id, :cuvee_id)
  end
end
