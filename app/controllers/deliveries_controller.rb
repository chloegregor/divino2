class DeliveriesController < ApplicationController
  def update
    @delivery = User.find(params[:user_id]).delivery
    if @delivery.update(delivery_params)
      flash[:success] = "Delivery updated"
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def delivery_params
    params.require(:delivery).permit(:delivery_method)
  end
end
