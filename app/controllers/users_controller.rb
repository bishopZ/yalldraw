class UsersController < ApplicationController
  def index
  end

  def new
  end

  def show
    @user = User.find params[:id]
    @drawings = Drawing.from_user @user
    @editable = current_user && current_user.id == @user.id

    rescue ArgumentError
    raise ActionController::RoutingError.new 'User not found, probably isnt real'
  end

  def login
    unless params.key? :user || params[:user][:name] || params[:user][:password]
      input_error 'All credentials must be filled out', users_path
    end

    user = User.login params[:user][:name], params[:user][:password]

    if user
      session[:user_id] = user.id
      redirect_to user_path user
    else
      input_error 'User name does not match what was expected', users_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/'
  end

  def create
    @user = User.register(params[:user])
    if @user.save
      flash[:notice] = "Congratulations: #{@user.name}, welcome to yalldraw"
      redirect_to new_drawing_path
    else
      render :action => :new
    end
  end

  private

  def input_error(message, path)
    flash[:error] = message
    redirect_to path
  end
end
