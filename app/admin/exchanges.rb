ActiveAdmin.register Exchange do
  remove_filter :initiator_box_exchanges
  remove_filter :recipient_box_exchanges
  permit_params :status, :recipient_id, :initiator_id,
  initiator_box_exchanges_attributes: [:id, :box_id, :role, :_destroy],
  recipient_box_exchanges_attributes: [:id, :box_id, :role, :_destroy]

  show do
    attributes_table do
      row :status
      row :initiator do |exchange|
        exchange.initiator.pseudo
      end
      row :recipient do |exchange|
        exchange.recipient.pseudo
      end
      table do
        thead do
          tr do
            th 'Box'
            th 'User'
          end
        end
        tbody do
          exchange.initiator_box_exchanges.each do |box_exchange|
            tr do
              td box_exchange.box.dividende.vinyard.name
              td box_exchange.box.user.pseudo
            end
          end
          exchange.recipient_box_exchanges.each do |box_exchange|
            tr do
              td box_exchange.box.dividende.vinyard.name
              td box_exchange.box.user.pseudo
            end
          end
        end
      end
    end
  end

  form do |f|

    f.inputs "Exchange" do
      f.input :status, as: :select, collection: ["pending", "accepted", "rejected"], prompt: "Sélectionnez un status"
      # f.input :initiator, as: :select, collection: User.all.map { |u| [u.pseudo, u.id] }, prompt: "Sélectionnez un initiateur", input_html: { class: 'initiator-select' }
      # f.input :recipient, as: :select, collection: User.all.map { |u| [u.pseudo, u.id] }, prompt: "Sélectionnez un destinataire", input_html: { class: 'recipient-select' }

      f.input :initiator, as: :select, collection: User.all.map { |u| [u.pseudo, u.id] }, prompt: "Sélectionnez un initiateur"
      f.input :recipient, as: :select, collection: User.all.map { |u| [u.pseudo, u.id] }, prompt: "Sélectionnez un destinataire"

    end
    div id: "initiator-boxes-container" do
      f.inputs "Initiator box exchanges" do
          f.has_many :initiator_box_exchanges, heading: false, allow_destroy: true do |b|
            initiator_box_exchanges = BoxExchange.where(role: "initiator", exchange_id: f.object.id)
            b.input :box, as: :select, collection: initiator_box_exchanges.map {|i| ["#{i.box.dividende.vinyard.name} - #{i.box.dividende.year}", i.box.id]}, input_html: { class: 'box-exchange-select', id: 'initiator-target-select' }, prompt: "Sélectionnez une boite"
            b.input :role, as: :hidden, input_html: { value: 'initiator' }
        end
      end
    end

    div id: "recipient-boxes-container" do
      f.inputs "Recipient box exchanges" do
        f.has_many :recipient_box_exchanges, heading: false, allow_destroy: true do |b|
          recipient_box_exchanges = BoxExchange.where(role: "recipient", exchange_id: f.object.id)
          b.input :box, as: :select, collection: recipient_box_exchanges.map {|i| ["#{i.box.dividende.vinyard.name} - #{i.box.dividende.year}", i.box.id]}, input_html: { class: 'box-exchange-select', id: 'recipient-target-select' }, prompt: "Sélectionnez une boite"
          b.input :role, as: :hidden, input_html: { value: 'recipient' }
        end
      end
    end
    f.actions
  end

  controller do
    def create
      super
      exchange = resource
      if exchange.status == "accepted"
        swap(exchange)
      end
    end

    def update
      super
      exchange = resource
      if exchange.status == "accepted"
        swap(exchange)
      end



    end

    private

    def swap(exchange)
      exchange.initiator_box_exchanges.each do |box_exchange|
        box_exchange.box.update(user_id: exchange.recipient_id)
      end
      exchange.recipient_box_exchanges.each do |box_exchange|
        box_exchange.box.update(user_id: exchange.initiator_id)
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
