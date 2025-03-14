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

  def edit
    @address = Address.find(params[:id])
    render 'addresses/edit_address'
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(edit_address_params)
      flash[:success] = "Address updated!"
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    flash[:success] = "Address deleted!"
    redirect_to user_path(current_user)
  end
private
  def address_params
    params.require(:addresses).permit(:title, :name, :zip, :street, :country, :city)
  end

  def edit_address_params
    params.require(:address).permit(:title, :name, :zip, :street, :country, :city)
  end

end
