class DrawingsController < ApplicationController
  def show
    @drawing = Drawing.find_by_id(params[:id]) || Drawing.first
    @values = @drawing.graphics.complete || []
    render 'index'
  end

  def new
  end

  def add
    (access_error && return) unless can_modify_drawing params[:drawing_id]

    graphic = Drawing
      .find(params[:drawing_id])
      .graphics
      .add(current_user.id, params[:drawing_id], params[:value])

    render json: graphic
  end

  def update
    (access_error && return) unless can_modify_drawing params[:id]
    (access_error && return) unless can_modify_graphic params[:id], params[:id]

    Drawing
      .find(params[:id])
      .graphics
      .modify(params[:graphic_id], params[:value], params[:z])
      .save

    render nothing: true
  end

  def remove
    (access_error && return) unless can_modify_drawing params[:drawing_id]
    (access_error && return) unless can_modify_graphic params[:drawing_id], params[:graphic_id]

    Drawing
      .find(params[:drawing_id])
      .graphics
      .remove params[:graphic_id]

    render nothing: true
  end

  def save
    user = User.find_by_name(params[:name])

    if current_user && user.id == current_user.id
      drawing = Drawing.find_by_slug user, params[:slug]
      Drawing.save drawing.did, params[:vectors]

      render nothing: true
    else
      access_error
    end
  end

  def draw
    @user = User.find_by_name params[:name]
    @drawing = @user.drawings.find_by_slug params[:slug]
    @graphics = @drawing.graphics.order :z
    @values = @graphics.complete

    render 'index'
  end

  def destroy
    drawing = Drawing.find params[:id]

    if current_user || drawing.user.id == current_user.id
      drawing.destroy
      render nothing: true
    else
      access_error
    end
  end

  def create
    Drawing.create_blank current_user, params[:slug]
    redirect_to "/#{current_user.name}/#{params[:slug]}"

    rescue ArgumentError

    flash[:error] = 'Error in registration'
    input_error 'Name already taken', '/users/new'
  end

  private

  def can_modify_graphic(drawing_id, graphic_id)
    true
  end

  def can_modify_drawing(drawing_id)
    true
  end

  def access_error
    render nothing: true, status: 401
  end
end
