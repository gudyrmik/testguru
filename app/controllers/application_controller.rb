class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

# работает, но предчуствие что это какая-то муть меня не оставляет и будешь ругаться:).
# наверняка ж проще можно?
# пни плз в правильную сторону
  def after_sign_in_path_for(user)
    if user.admin?
      admin_tests_path 
    else
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

end
