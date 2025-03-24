ActiveAdmin.register Vinyard do

  permit_params :name, :description,
              vinyard_appellations_attributes: [:id, :name, :appellation_id, :_destroy,
                cuvees_attributes: [:id, :name, :_destroy,
                cuvee_colors_attributes: [:id, :description, :color_id, :_destroy]
              ]
            ],
            dividendes_attributes: [:id, :year, :shipping_date, :_destroy,
              dividende_cuvee_colors_attributes: [:id, :cuvee_color_id, :bottle_quantity, :_destroy]
          ], stock_owners_attributes: [:id, :quantity, :_destroy, :user_id]

  index do
    selectable_column
    column "vinyard's name",:name
    column "appellation(s)", :vinyard_appellations, label: "appellation(s)" do |vinyard|
      vinyard.vinyard_appellations.map { |va| va.appellation.name }.join(', ').html_safe
    end
    column "address", :address
    actions
  end

  show do
    attributes_table do
      row :name
      row :address
      row :description
    end
    vinyard.vinyard_appellations.each do |va|
      panel "Appellation #{va.appellation.name}" do
       table_for va.cuvee_colors do
          column 'Cuvee' do |cc|
            cc.cuvee.name
          end
          column 'Color' do |cc|
            cc.color.color
          end
        end
      end
    end
    vinyard.dividendes.each do |dividende|
      panel "Dividende #{dividende.year}" do
        table_for dividende.dividende_cuvee_colors do
          column 'Cuvee' do |dcc|
            dcc.cuvee_color.cuvee.name
          end
          column 'Color' do |dcc|
            dcc.cuvee_color.color.color
          end
          column 'Bottle Quantity' do |dcc|
            dcc.bottle_quantity
          end
        end
      end
    end
    panel 'Stock Owners' do
      table_for vinyard.stock_owners do
        column 'User' do |so|
          so.user.email
        end
        column 'Quantity' do |so|
          so.quantity
        end
      end
    end
  end

  form do |f|
    f.inputs 'Vinyard' do
      f.input :name, label:  'Name'
      f.input :address, label: 'Address'
      f.input :description
    end
    f.has_many :vinyard_appellations, heading: 'Appellations', allow_destroy: true do |va|
      va.input :appellation_id, as: :select, collection: Appellation.all.pluck(:name, :id), label: 'Choose Appellation'
      va.has_many :cuvees, heading: 'Cuvees', allow_destroy: true do |cuvee|
        cuvee.input :name, label: ' Name'
        cuvee.has_many :cuvee_colors, heading: 'Colors', allow_destroy: true do |cc|
          cc.input :color_id, as: :select, collection: Color.all.pluck(:color, :id), label: 'Choose Color'
          cc.input :description, label: 'Description', as: :text
          end
      end
    end

    f.has_many :dividendes, heading: 'Dividendes', allow_destroy: true do |dividende|
      dividende.input :year
      dividende.input :shipping_date, as: :datepicker
      dividende.has_many :dividende_cuvee_colors, heading: 'Bottle', allow_destroy: true do |dcc|
        cuvee_colors = CuveeColor.joins(cuvee: :vinyard_appellation).where(vinyard_appellations: { vinyard_id: f.object.id })
        dcc.input :cuvee_color_id, as: :select, collection: cuvee_colors.map { |cc| ["#{cc.cuvee.name} en #{cc.cuvee.vinyard_appellation.appellation.name} | #{cc.color.color}", cc.id] }, label: 'Choose Cuvee Color'
        dcc.input :bottle_quantity
      end
    end

    f.actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :description
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
