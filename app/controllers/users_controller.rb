class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    current_year = Time.current.year
    @non_exchangeable_boxes = @user.boxes.where(exchangeable: false)
                 .joins(:dividende)
                 .where(dividende: { year: current_year })
                 .includes(:vinyard)
                 .group_by(&:vinyard)

    @exchangeable_boxes = @user.boxes.where(exchangeable: true)
                 .joins(:dividende)
                 .where(dividende: { year: current_year })
                 .includes(:vinyard)
                 .group_by(&:vinyard)
    @exchange = Exchange.new
    @exchange.box_exchanges.build
    @delivery = @user.delivery
    @address = @user.addresses.build
    @addresses = @user.addresses
    @delivery_address = @delivery.address
  end


end
