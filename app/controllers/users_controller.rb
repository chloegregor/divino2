class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @boxes = @user.boxes.includes(:vinyard).group_by(&:vinyard)
    @exchange = Exchange.new
    @exchange.box_exchanges.build
  end


  def cellar
    @user = current_user
    @dividende = @user.dividendes
  end
end
