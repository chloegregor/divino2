class BoxesController < ApplicationController

  def edit
    @user = User.find(params[:user_id])
    @box = Box.find(params[:id])
    @slots = @box.dividende.slots.map {|slot| (slot.start_date..slot.end_date).to_a}.flatten
    puts "Turbo Frame edit appelé pour box #{@box.id}"
    render "boxes/edit_box"
  end

  def update
    @box = Box.find(params[:id])
    if @box.update(box_params)
      if @box.delivery_method == "pickup"
        @box.update(address_id: nil)
        if @box.pick_up_date.present?
          @box.pick_up_date.update(pick_up_date_params)
        else
          @box.create_pick_up_date(pick_up_date_params)
        end
      end

      flash[:success] = "Box updated!"
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def box_params
    params.require(:box).permit(:exchangeable, :delivery_method, :address_id )
  end

  def pick_up_date_params
    params.require(:pick_up_date).permit(:date)
  end

end
