ActiveAdmin.register User do
  permit_params :pseudo, :delivery_address, :email, :password, :password_confirmation, boxes_attributes: [:id, :dividende_id, :_destroy,
                dividendes_cuvee_colors_attributes: [:id, :cuvee_color_id, :bottle_quantity, :_destroy]
              ]


  index do
    selectable_column
    column :pseudo
    column :delivery_address
    column :email
    actions
  end

  show do
    attributes_table do
      row :pseudo
      row :delivery_address
      row :email
      row :boxes do |user|
        user.boxes.map do |box|
          link_to "#{box.dividende.vinyard.name} #{box.dividende.year}##{box.id}", admin_box_path(box)
        end.join(', ').html_safe
      end
    end
  end

  form do |f|
    f.inputs "User" do
      f.input :pseudo
      f.input :delivery_address
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.inputs "boxes" do
      f.has_many :boxes, heading: false, allow_destroy: true do |b|
        b.input :dividende,
                as: :select,
                collection: Dividende.all.map { |d| ["#{d.vinyard.name} - #{d.year}", d.id] },
                prompt: "Sélectionnez un dividende"
      end
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :pseudo, :delivery_address, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:pseudo, :delivery_address, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
