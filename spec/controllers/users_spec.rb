require 'spec_helper'

describe UsersController, 'create a new user' do
  let(:user_params){ { :user => { :name => 'trent', :password => 'my password', :password1 => 'my password' } } }

  it 'should redirect to drawing create on succesful create' do
    User.any_instance.stubs(:valid?).returns(true)
    post 'create', user_params
    assigns[:user].should_not be_new_record
    flash[:notice].should_not be_nil
    response.should redirect_to(new_drawing_path)
  end

  it 'should render the new template on failed save' do
    User.any_instance.stubs(:valid?).returns(false)
    post 'create', user_params
    assigns[:user].should be_new_record
    flash[:notice].should be_nil
    response.should render_template(:new)
  end

  it 'should pass params to user' do
    post 'create', user_params
    assigns[:user].name.should == 'trent'
  end
end
