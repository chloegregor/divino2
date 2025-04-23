class CuveesController < ApplicationController
  def create

    @cuvee = Cuvee.new(cuvee_params)
    if @cuvee.save
      @cuvee_color = CuveeColor.new(cuvee_color_params.merge(cuvee_id: @cuvee.id))
      if @cuvee_color.save
        @vinyard_appellation = VinyardAppellation.find(@cuvee.vinyard_appellation_id)
        @vinyard = Vinyard.find(@vinyard_appellation.vinyard_id)
        redirect_to vinyard_path(@vinyard)
      else
        @cuvee.destroy

      end

    else
      render 'cuvees_colors/new', formats: :turbo_stream
    end
  end

  private

  def cuvee_params
    params.require(:cuvee).permit(:name, :vinyard_id, :vinyard_appellation_id)
  end

  def cuvee_color_params
    params.require(:cuvee_color).permit(:description, :color_id)
  end
end
