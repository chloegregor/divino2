class BoxesController < ApplicationController

  def edit
    @user = User.find(params[:user_id])
    @box = Box.find(params[:id])
    puts "Turbo Frame edit appelé pour box #{@box.id}"
    render "boxes/edit_box"
  end

  def update
    @box = Box.find(params[:id])
    if @box.update(box_params)
      flash[:success] = "Box updated!"
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def box_params
    params.require(:box).permit(:exchangeable, :delivery_method, :address_id)
  end

end
