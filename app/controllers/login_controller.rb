class LoginController < ApplicationController
        before_filter :authorize, :except => :login ; :logout
        before_filter :validate_user_identity, :only => :admin
  def index

    redirect_to_correct_home_page

  end

  def login
        if !session[:userType].nil?
          redirect_to_correct_home_page
        elsif request.post?
          session.clear
          user = User.authenticate(params[:userName], params[:password])
          if user
            session[:userName] = user.userName
            session[:userId]  = user.id
            session[:userType]  = user.userType
            session[:fname]=user.fname
            redirect_to_correct_home_page
          else
          flash[:error] = "Invalid Username or Password"
           params[:userName] = nil
           params[:password] = nil
          end
        end

  end

  def show


  end

  def logout

    if request.post?
      session.clear
      flash[:notice] = "Logged-Out Successfully"
      redirect_to(:controller => "login", :action => "login")
    end

  end

  def user
    redirect_to(:controller => "posts")
  end

  def admin
    #if session[:userType]  == "student"
     # redirect_to(:controller => "login", :action => "user")
      #flash[:notice] = "You are not authorized to view this functionality"
      #end
  end

  def redirect_to_correct_home_page
    if session[:userType]  == "student"
      redirect_to(:controller => "login", :action => "user")
    elsif  session[:userType]  == "admin"   || session[:userType]  == "super"
      redirect_to(:controller => "login", :action => "admin")
    end
  end

  end





