class DrawingsController < ApplicationController
  def index
    show
  end

  def show
    @drawing = Drawing.find_by_id(params[:id]) || Drawing.first
    @values = @drawing.graphics.complete || []
    render 'index'
  end

  def new
  end

  def add
    if can_modify_drawing params[:drawing_id]
      graphic = Drawing.find(params[:drawing_id]).graphics
        .add(current_user.id, params[:drawing_id], params[:value])

      render json: graphic
    else
      access_error
    end
  end

  def update
    if can_modify_drawing(params[:id]) && can_modify_graphic(params[:id], params[:drawing_id])
      Drawing.find(params[:id]).graphics
        .modify(params[:graphic_id], params[:value], params[:z])
        .save

      render nothing: true
    else
      access_error
    end
  end

  def remove
    if can_modify_drawing(params[:id]) && can_modify_graphic(params[:id], params[:drawing_id])
      Drawing
        .find(params[:drawing_id])
        .graphics
        .destroy params[:graphic_id]

      render nothing: true
    else
      access_error
    end
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
    drawing = Drawing.create_blank current_user, params[:slug]
    if drawing
      redirect_to drawing_path(drawing)
    else
      flash[:error] = 'Error in registration'
      redirect_to new_drawing_path
    end
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
