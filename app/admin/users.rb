ActiveAdmin.register User do
  permit_params :pseudo, :email, :password, :password_confirmation, :role, boxes_attributes: [:id, :dividende_id, :_destroy,
                dividendes_cuvee_colors_attributes: [:id, :cuvee_color_id, :bottle_quantity, :_destroy]
              ]


  index do
    selectable_column
    column :pseudo
    column :email
    column :delivery_address do |user|
      user.delivery && user.delivery.address ? "#{user.delivery.address.name} - #{user.delivery.address.street}, #{user.delivery.address.zip} #{user.delivery.address.city}, #{user.delivery.address.country}": "No address"
    end
    actions
  end

  show do
    attributes_table do
      row :pseudo
      row :email
      row :delivery_address do |user|
        user.delivery.address ? "#{user.delivery.address.name} - #{user.delivery.address.street}, #{user.delivery.address.zip} #{user.delivery.address.city}, #{user.delivery.address.country}": "No address"
      end
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
      f.input :email
      f.input :password
      f.input :password_confirmation
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
