ActiveAdmin.register Box do
  permit_params :user_id, :dividende_id

  index do
    selectable_column
    column :id
    column :user_email do |box|
      box.user.email
    end
    column :user_pseudo do |box|
      box.user.pseudo
    end
    column :dividende do |box|
      "#{box.dividende.vinyard.name} #{box.dividende.year}"
    end

    column :delivery_address do |box|
      box.user.delivery_address
    end
    actions
  end

  show do
    attributes_table do
      row :user_email do |box|
        box.user.email
      end
      row :user_pseudo do |box|
        box.user.pseudo
      end
      row :dividende do |box|
        "#{box.dividende.vinyard.name} #{box.dividende.year}"
      end
      row :delivery_address do |box|
        box.user.delivery_address
      end
      table do
        thead do
          tr do
            th 'Cuvee'
            th 'Color'
            th 'Bottle Quantity'
          end
        end
        tbody do
          box.dividende.dividende_cuvee_colors.each do |dcc|
            tr do
              td dcc.cuvee_color.cuvee.name
              td dcc.cuvee_color.color.color
              td dcc.bottle_quantity
            end
          end
        end
      end
    end
  end

  form do |f|
    f.inputs "Box" do
      f.input :user,
              as: :select,
              collection: User.all.map { |u| ["#{u.email} - #{u.pseudo}", u.id] },
              prompt: "Sélectionnez un utilisateur"
      f.input :dividende,
              as: :select,
              collection: Dividende.all.map { |d| ["#{d.vinyard.name} - #{d.year}", d.id] },
              prompt: "Sélectionnez un dividende"
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :dividende_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :dividende_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  filter :user_email, as: :string
  filter :user_pseudo, as: :string
  filter :dividende_vinyard_name, as: :select, collection: -> { Vinyard.distinct.pluck(:name).sort }
  filter :dividende_year, as: :select, collection: -> { Dividende.distinct.pluck(:year).sort.reverse }
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :dividende_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:dividende_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
