ActiveAdmin.register StockOwner do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :vinyard_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:vinyard_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :vinyard_id, :user_id, :quantity

  form do |f|
    f.inputs do
      f.input :vinyard
      f.input :user, as: :select, collection: User.all.map { |user| [user.pseudo, user.id] }
      f.input :quantity
    end
    f.actions
  end
end
