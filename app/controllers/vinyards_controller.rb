require 'csv'
class VinyardsController < ApplicationController
  def index
    @vinyards = Vinyard.all
    @regions = Vinyard.select(:region).distinct.map(&:region)
    @region = params[:region]
    @appellation = params[:appellation]

    if @region.present?
      @vinyards = @vinyards.where(region: @region)
      @selected_vinyards = Vinyard.where(region: @region)

    else
      @selected_vinyards = Vinyard.all

    end


    if @appellation.present?
      @vinyards = @vinyards.joins(:appellations).where(appellations: { name: @appellation })

    end

    @vinyards = @vinyards.order(:region)

  end

  def show
    @vinyard = Vinyard.find(params[:id])
    @vinyard_dividendes = @vinyard.dividendes.order(year: :desc)
    @stock_owners = @vinyard.stock_owners.joins(:user).map(&:user).uniq
    @vinyard_appellations = @vinyard.vinyard_appellations
    @dividendes = @vinyard.dividendes.current_year
    @dividende = @vinyard.dividendes.current_year.first
    if @dividende.nil?
      render 'vinyards/show_no_dividende'
    else
      @bottles = @dividende.dividende_cuvee_colors
      @appellations = @dividende.vinyard_appellations
      @users = Box.where(dividende_id: @dividende.id, exchangeable: true).includes(:user).map(&:user).uniq
      @slots = @dividende.slots
    end

  end

  def shipments_to_csv
    @vinyard = Vinyard.find(params[:id])
    @dividende = @vinyard.dividendes.current_year.first
    @boxes = @dividende.boxes.where(delivery_method: "shipment")
    csv_data = CSV.generate do |csv|
      csv << [ "domaine", "method", "recipient", "name", "address", "postal code", "city", "country"]
      @boxes.each do |box|
        csv << [
          box.vinyard.name,
          box.delivery_method,
          box.user.email,
          box.address.name,
          box.address.street,
          box.address.zip,
          box.address.city,
          box.address.country
        ]
      end
    end
    send_data csv_data, filename: "#{@vinyard.name}_#{@dividende.year}_shipments.csv"
  end

  def pick_ups_to_csv
    @vinyard = Vinyard.find(params[:id])
    @dividende = @vinyard.dividendes.current_year.first
    @boxes = @dividende.boxes.where(delivery_method: "pickup")
    csv_data = CSV.generate do |csv|
      csv << [ "domaine", "method", "recipient", "date of pick up"]
      @boxes.each do |box|
          csv << [
            box.vinyard.name, box.delivery_method, box.user.email,
            box.pick_up_date&.date&.strftime("%d/%m/%Y")
          ]
      end
    end
    send_data csv_data, filename: "#{@vinyard.name}_#{@dividende.year}_pick_up.csv"
  end

  def edit_description
    @vinyard = Vinyard.find(params[:id])
    render 'vinyards/edit_description'
  end

  def edit_region
    @vinyard = Vinyard.find(params[:id])
    render 'vinyards/edit_region'
  end

  def edit_address
    @vinyard = Vinyard.find(params[:id])
    render 'vinyards/edit_address'
  end

  def update
    @vinyard = Vinyard.find(params[:id])
    @vinyard.update(vinyard_params)
    redirect_to vinyard_path(@vinyard)
  end

  private

  def vinyard_params
    params.require(:vinyard).permit(:description, :region, :address)
  end

end
