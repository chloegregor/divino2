class ApplicationController < ActionController::Base
  helper_method :stars_amount

  def stars_amount(current_user)
    stars = 0
    current_user.boxes.each do |box|
      stars += box.dividende.value
    end
    return stars
  end
end
