ActiveAdmin.register Exchange do
  permit_params :status, :recipient_id, :initiator_id,
   box_exchanges_attributes: [:id, :box_id, :role, :_destroy]

  form do |f|

    f.inputs "Exchange" do
      f.input :status, as: :select, collection: ["pending", "accepted", "rejected"], prompt: "Sélectionnez un status"
      # f.input :initiator, as: :select, collection: User.all.map { |u| [u.pseudo, u.id] }, prompt: "Sélectionnez un initiateur", input_html: { class: 'initiator-select' }
      # f.input :recipient, as: :select, collection: User.all.map { |u| [u.pseudo, u.id] }, prompt: "Sélectionnez un destinataire", input_html: { class: 'recipient-select' }

      f.input :initiator, as: :select, collection: User.all.map { |u| [u.pseudo, u.id] }, prompt: "Sélectionnez un initiateur"
      f.input :recipient, as: :select, collection: User.all.map { |u| [u.pseudo, u.id] }, prompt: "Sélectionnez un destinataire"

    end
    f.inputs " Boxes" do
      f.has_many :box_exchanges, heading: false, allow_destroy: true do |b|
        b.input :box, as: :select, collection: [], input_html: { class: 'box-exchange-select' }, prompt: "Sélectionnez une boite"
        b.input :role, as: :select, collection: ["initiator", "recipient"], prompt: "Sélectionnez un role", input_html: { class: 'role-select' }
      end
    end

    f.actions
  end

  controller do
    def create
      @exchange = Exchange.new(exchange_params)
      if @exchange.save
        swap_boxes(@exchange) if @exchange.status == "accepted"

        redirect_to admin_exchanges_path
      else
        render :new
      end
    end

   private

    def exchange_params
      params.require(:exchange).permit(:status, :recipient_id, :initiator_id, box_exchanges_attributes: [:id, :role, :box_id, :_destroy])
    end

    def swap_boxes(exchange)
      initiator = exchange.initiator
      recipient = exchange.recipient
      binding.pry
      new_owner = {}
      exchange.initiator_boxes.each do |box|
          new_owner[box.id] = recipient
      end
      exchange.recipient_boxes.each do |box|
          new_owner[box.id] = initiator
      end
      new_owner.each do |box_id, user|
        Box.find(box_id).update!(user: user)
      end
    end
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :status, :recipient_id, :initiator_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:status, :recipient_id, :initiator_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
