class ColorsController < ApplicationController
  def create
    @color = Color.new(color_params)
    if @color.save
      redirect_to colors_path, notice: 'Color was successfully created.'
    else
      render :new
    end
  end

  private
  def color_params
    params.require(:color).permit(:color)
  end
end
