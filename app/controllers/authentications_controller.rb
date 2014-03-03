class AuthenticationsController < ApplicationController

  skip_before_filter :require_login

  def handle_unverified_request
    true
  end

  def index
    @authentications = current_user.authentications if current_user
    render :layout => "landing"
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'] , omniauth['uid'])
    
		if authentication && authentication.user.present?      
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user , authentication.user)
    elsif current_user
      current_user.authentications.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      user = User.new
      # TODO : Specific handle for each provider
      user.apply_omniauth(omniauth)
      require 'debugger';debugger
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end

  def destroy
    @authentication =  current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
