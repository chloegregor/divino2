class AddressesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @address = @user.addresses.build
    render 'addresses/new_address'
  end

  def create
    @user = User.find(params[:user_id])
    @address = @user.addresses.build(address_params)

    if @address.save
      flash[:success] = "Address added!"
      redirect_to user_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end
private
  def address_params
    params.require(:addresses).permit(:title, :name, :zip, :street, :country)
  end

end
