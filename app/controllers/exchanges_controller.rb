class ExchangesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @pending_exchanges = Exchange.includes(box_exchanges: :box).where(status: "pending")
    @accepted_exchanges = Exchange.includes(box_exchanges: :box).where(status: "accepted")
    @rejected_exchanges = Exchange.includes(box_exchanges: :box).where(status: "rejected")
    @user_pending_exchanges_as_initiator = @pending_exchanges.where(initiator: @user)
    @user_pending_exchanges_as_recipient = @pending_exchanges.where(recipient: @user)
    @user_accepted_exchanges = @accepted_exchanges.where("initiator_id = ? OR recipient_id = ?", @user.id, @user.id).order(created_at: :desc)
    @user_rejected_exchanges = @rejected_exchanges.where("initiator_id = ? OR recipient_id = ?", @user.id, @user.id).order(created_at: :desc)
    @user_rejected_exchanges_as_initiator = @rejected_exchanges.where(initiator: @user)
    @user_rejected_exchanges_as_recipient = @rejected_exchanges.where(recipient: @user)
  end

  def create
    @exchange = Exchange.new(exchange_params)
    if @exchange.save
      redirect_to user_path(@exchange.recipient)
    else
      render :new
    end
  end

  def load_boxes
    puts "PARAMS REÇUS coucou chloe : #{params.inspect}" # ➜ Debug pour voir tous les paramètres reçus
    user_id = load_boxes_params[:user_id]
    # Récupérer les boîtes de l'initiator sélectionné
    boxes = Box.where(user_id: user_id).includes(:dividende).includes(:vinyard) # Vous pouvez ajouter d'autres critères si nécessaire
    render json: boxes.as_json(include: [:dividende, :vinyard])
  end

  def accepted_exchanges
    @exchange = Exchange.find(update_params[:exchange_id])
    @exchange.status = "accepted"
    @exchange.save
    initiator = @exchange.initiator
    recipient = @exchange.recipient
    @exchange.boxes.each do |box|
      if box.user == initiator
        box.user = recipient
      elsif box.user == recipient
        box.user = initiator
      end
      box.save
    end
    redirect_to user_exchanges_path(current_user)
  end

  def rejected_exchanges
    @exchange = Exchange.find(update_params[:exchange_id])
    @exchange.status = "rejected"
    @exchange.save
    redirect_to user_exchanges_path(current_user)
  end
  private
  def exchange_params
    params.require(:exchange).permit(:recipient_id, :initiator_id, box_exchanges_attributes: [:box_id])
  end

  def update_params
    params.permit(:exchange_id)
  end

  def load_boxes_params
    filtered_params = params.except(:exchange)
    filtered_params.permit(:user_id)
  end

end
