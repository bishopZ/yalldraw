require 'spec_helper'

describe User do
  describe 'register' do
    let(:user) {
      User.new.tap do |u|
        u.name = 'trentzz'
        u.password = '123456'
      end
    }

    it 'should be valid' do
      user.should be_valid
    end

    it 'should require a name' do
      user.name = ''
      user.should_not be_valid
    end

    it 'should require a long name' do
      user.name = 'bob'
      user.should_not be_valid
    end

    it 'should verify passwords are equal' do
      User.register(name: 'test', password: 'pizza', password1: 'pasidf').should be_false
    end
  end
end
