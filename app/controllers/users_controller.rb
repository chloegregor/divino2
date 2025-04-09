class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    current_year = Time.current.year
    @current_boxes = Box.joins(:dividende).left_joins(:pick_up_date).where(user_id: @user.id).where("dividendes.year = ?", current_year)
    .order(Arel.sql("CASE
    WHEN boxes.delivery_method = 'shipment' THEN dividendes.shipping_date
    ELSE pick_up_dates.date
    END ASC"))

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
    if @user.addresses.any?
      @addresses = @user.addresses
    end
    if @delivery.address
        @delivery_address = @delivery.address
    end

  end


end
