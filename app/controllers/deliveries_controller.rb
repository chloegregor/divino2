class DeliveriesController < ApplicationController
  def update
    @user = User.find(params[:user_id])
    @delivery = @user.delivery
    @boxes_to_be_delivered = @user.boxes.where(exchangeable: false)

    if @delivery.update(delivery_params)
      if @delivery.delivery_method == "pickup"
        @boxes_to_be_delivered.update_all(delivery_method: "pickup", address_id: nil)
      else
        @boxes_to_be_delivered.update_all(delivery_method: "shipment", address_id: @delivery.address_id)
      end
      flash[:success] = "Delivery updated"
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def delivery_params
    params.require(:delivery).permit(:delivery_method, :address_id)
  end
end
