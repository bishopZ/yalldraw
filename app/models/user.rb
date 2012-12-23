class User < ActiveRecord::Base
  attr_accessible :name, :password

  validates_uniqueness_of :name
  has_many :drawings

  def self.login(name, password)
    find_by_name_and_password(name, encrypt(password))
  end

  def self.register(params)
    # TODO: these should be validated
    return false unless params[:password] == params[:password1]
    return false if params[:name].size < 3
    return false if find_by_name name

    new.tap do |u|
      u.name = params[:name]
      u.password = encrypt params[:password]
    end
  end

  # TODO: fix this
  def self.encrypt(value)
    Digest::SHA1.base64digest('cheesepotatoe' + value)
  end
end
