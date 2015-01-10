class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  before_filter :authorize , :only => :index ; :show  ; :destroy
  before_filter :validate_user_identity

 def index
  @users = User.all

  respond_to do |format|
    format.html # index.html.erb
    format.json { render json: @users }
  end
end

# GET /users/1
# GET /users/1.json
def show
  @user = User.find(params[:id])

  respond_to do |format|
    format.html # show.html.erb
    format.json { render json: @user }
  end
end

# GET /users/new
# GET /users/new.json
def new
  @user = User.new

  respond_to do |format|
    format.html # new.html.erb
    format.json { render json: @user }
  end
end

# GET /users/1/edit
def edit
  @user = User.find(params[:id])
end

# POST /users
# POST /users.json
def create

  @user = User.new(params[:user])

  respond_to do |format|
    if @user.save

      format.html { redirect_to :action => :save_new_user }

    else
      format.html { render action: "new" }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end

# PUT /users/1
# PUT /users/1.json
  def update
    if !params[:user_id].nil?
      @user = User.find(params[:user_id])

      respond_to do |format|
        if @user.update_attributes(:userType => params[:user_type])
          flash[:notice] = "Successfully Updated"
          format.html { redirect_to( :action => "index") }
          format.json { head :no_content }
        else
          flash[:notice] = "Update Unsuccessful"
          format.html { redirect_to( :action => "index") }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      @user = User.find(params[:id])

      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end

    end
  end

# DELETE /users/1.json
  def destroy

      @user = User.find(params[:id])

      if @user.id == session[:userId]
        @user.destroy
        session[:userName] = nil
        session[:userId]  = nil
        session[:userType]  = nil
        session[:fname] = nil

          redirect_to users_url

      else
        @user.destroy
        flash[:notice] = "User Successfully Deleted"
        respond_to do |format|
          format.html { redirect_to users_url }
          format.json { head :no_content }
        end

      end

  end

def save_new_user

end


end