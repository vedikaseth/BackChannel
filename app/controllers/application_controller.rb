class ApplicationController < ActionController::Base
  protect_from_forgery
  private
  def authorize
    if session[:userName].nil?
      flash[:notice] = "Please Log In"
      redirect_to(:controller => "login", :action => "login")
    end
  end

  def validate_user_identity
    if session[:userType]  == "student"
      redirect_to(:controller => "login", :action => "user")
      flash[:notice] = "You are not authorized to view this functionality"
    end
  end

  end
