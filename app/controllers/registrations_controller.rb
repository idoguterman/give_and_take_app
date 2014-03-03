class RegistrationsController < Devise::RegistrationsController
  
  after_filter :delete_omniauth, :only => :create

  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  protected
  def delete_omniauth

    session[:omniauth] = nil unless @user.new_record?
  end  

  private
  
  
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.save! if @user.valid?
    end
    self.resource
  end
end
