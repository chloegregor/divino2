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
    div id: "initiator-boxes-container" do
      f.inputs "Initiator box exchanges" do
          f.has_many :box_exchanges, heading: false, allow_destroy: true do |b|
            b.input :box, as: :select, collection: [], input_html: { class: 'box-exchange-select', id: 'initiator-target-select' }, prompt: "Sélectionnez une boite"
            b.input :type, as: :hidden, input_html: { value: 'InitiatorBoxExchange' }
        end
      end
    end

    div id: "recipient-boxes-container" do
      f.inputs "Recipient box exchanges", wrapper_html: { id: "recipient-box-container" } do
        f.has_many :box_exchanges, heading: false, allow_destroy: true do |b|
          b.input :box, as: :select, collection: [], input_html: { class: 'box-exchange-select', id: 'recipient-target-select' }, prompt: "Sélectionnez une boite"
          b.input :type, as: :hidden, input_html: { value: 'RecipientBoxExchange' }
        end
      end
    end
    f.actions
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
