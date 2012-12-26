require 'spec_helper'

describe UsersController, 'Registering a new user' do
  let(:user_params){ { :user => { :name => 'trent', :password => 'my password', :password1 => 'my password' } } }

  context 'when successful registration' do
    it 'should redirect to drawing create' do
      User.any_instance.stubs(:valid?).returns(true)
      post 'create', user_params
      assigns[:user].should_not be_new_record
      flash[:notice].should_not be_nil
      response.should redirect_to(new_drawing_path)
    end
  end

  context 'when failed registration' do
    it 'should render the new template' do
      User.any_instance.stubs(:valid?).returns(false)
      post 'create', user_params
      assigns[:user].should be_new_record
      flash[:notice].should be_nil
      response.should render_template(:new)
    end
  end

  it 'should pass params to user' do
    post 'create', user_params
    assigns[:user].name.should == 'trent'
  end
end

describe UsersController, 'Login user' do
  context 'when successful login' do
    let(:login_params) { { :user => {} } }
    it 'should set user.id in session' do
      User.stubs(:login).returns(User.new.tap do |u|
        u.id = 3
        u.name = 'super'
      end)
      post 'login', login_params
      session[:user_id].should_not be_nil
    end
  end

  context 'when failed login' do
    let(:login_params) { { :user => {} } }
    it 'should flash error and redirect' do
      User.stubs(:login).returns(false)
      post 'login', login_params
      flash[:error].should_not be_nil
      response.should redirect_to(users_path)
    end
  end
end

describe UsersController, 'Logout' do
  it 'should clear session and redirect' do
    post 'logout'
    session[:user_id].should be_nil
    response.should redirect_to '/'
  end
end
