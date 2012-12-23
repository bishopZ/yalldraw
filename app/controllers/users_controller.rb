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
    user = User.login params[:user][:name], params[:user][:password]

    if user
      session[:user_id] = user.id
      redirect_to user_path user
    else
      flash[:error] = 'User name does not match what was expected'
      redirect_to users_path
    end
  end

  def logout
    session[:user_id] = nil
    # TODO: root
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
end
