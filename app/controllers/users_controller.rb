class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    current_year = Time.current.year

    # Filtrer les boîtes qui sont associées à des dividendes de l'année en cours
    @boxes = @user.boxes
                 .joins(:dividende)
                 .where(dividende: { year: current_year })
                 .includes(:vinyard)
                 .group_by(&:vinyard)
    @exchange = Exchange.new
    @exchange.box_exchanges.build
  end


end
