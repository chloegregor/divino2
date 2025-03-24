class Users::RegistrationsController < Devise::RegistrationsController

  def new
    super
  end


  def create
    @user = User.new(sign_up_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :pseudo)
  end

end
