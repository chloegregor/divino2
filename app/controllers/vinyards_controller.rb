class VinyardsController < ApplicationController
  def index
    @vinyards = Vinyard.all
  end

  def show
    @vinyard = Vinyard.find(params[:id])
    @vinyard_dividendes = @vinyard.dividendes.order(year: :desc)

    @dividendes = @vinyard.dividendes.current_year
    @dividende = @vinyard.dividendes.current_year.first
    @boxes_to_send = @dividende.boxes.where(delivery_method:"shipment")
    @boxes_to_pickup = @dividende.boxes.where(delivery_method:"pickup")
    @stock_owners = @vinyard.stock_owners.joins(:user).map(&:user).uniq

    @bottles = @dividende.dividende_cuvee_colors
    @appellations = @dividende.vinyard_appellations
    @users = Box.where(dividende_id: @dividende.id, exchangeable: true).includes(:user).map(&:user).uniq
    @vinyard_appellations = @vinyard.vinyard_appellations

  end


  def edit
    @vinyard = Vinyard.find(params[:id])
    render 'vinyards/edit_description'
  end

  def update
    @vinyard = Vinyard.find(params[:id])
    @vinyard.update(vinyard_params)
    redirect_to vinyard_path(@vinyard)
  end

  private

  def vinyard_params
    params.require(:vinyard).permit(:description)
  end

end
