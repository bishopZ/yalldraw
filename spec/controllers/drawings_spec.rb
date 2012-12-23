require 'spec_helper'

describe DrawingsController, 'Creating a new drawing' do
  let(:my_drawing){
    Drawing.new.tap do |d|
      d.id = 3
    end
  }

  context 'when successful creation' do
    it 'should redirect to new drawing path' do
      Drawing.stubs(:create_blank).returns(my_drawing)
      post 'create'
      response.should redirect_to(drawing_path(my_drawing))
    end
  end

  context 'when unsuccessful creation' do
    it 'should error and redirect to drawing path' do
      Drawing.stubs(:create_blank).returns(nil)
      post 'create'
      flash[:error].should_not be_nil
      response.should redirect_to(new_drawing_path)
    end
  end
end

describe DrawingsController, 'Show' do
  let(:my_drawing){
    Drawing.new.tap do |d|
      d.id = 3
    end
  }
  context 'when no id parameter' do
    it 'should default to first drawing' do
      Drawing.stubs(:find_by_id).returns(nil)
      Drawing.stubs(:first).returns(my_drawing)
      get :index
      assigns[:drawing].should == my_drawing
      response.should render_template(:index)
    end
  end

  context 'when id' do
    it 'should display' do
      Drawing.stubs(:find_by_id).returns(my_drawing)
      get :show, { :id => 3 }
      assigns[:drawing].should == my_drawing
      response.should render_template(:index)
    end
  end
end
