class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception




  private

  def post_params
    params.require(:post).permit(:blurb)
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    if !current_user_session
      flash[:warning] = "You must be logged in!"
      redirect_to root_path
    end
  end

  helper_method :current_user_session, :current_user, :require_user

end
