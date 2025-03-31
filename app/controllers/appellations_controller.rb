class AppellationsController < ApplicationController

  def new
    @appellation = Appellation.new
  end

  def create
    @appellation = Appellation.new(appellation_params)
    if @appellation.save
      @vinyard_appellation = VinyardAppellation.create(vinyard_appellation_params.merge(appellation_id: @appellation.id))
      if @vinyard_appellation.save
        redirect_to vinyard_path(@vinyard_appellation.vinyard)
      else
        render 'appellations/form'
      end
    end
  end

  private

  def appellation_params
    params.require(:appellation).permit(:name)
  end

  def vinyard_appellation_params
    params.require(:appellation).permit(:vinyard_id)
  end

end
