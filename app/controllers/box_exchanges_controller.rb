class BoxExchangesController < ApplicationController
  def new
    current_year = Time.current.year
    @role = params[:role]
    puts "=== DEBUG ==="
    puts "Role: #{@role}"
    puts "Boxes: #{@boxes.inspect}"
    puts "=== DEBUG ==="
puts "Params: #{params.inspect}"


    if @role == "initiator"
      @boxes = current_user.boxes.where(exchangeable: true).includes(:dividende)
      .where(dividendes: { year: current_year })
      render 'box_exchanges/new_initiator'
    elsif @role == "recipient"
      @boxes = User.find(params[:user_id]).boxes.where(exchangeable: true).includes(:dividende)
      .where(dividendes: { year: current_year })
      render 'box_exchanges/new_recipient'
    end



  end
end
