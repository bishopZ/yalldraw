class User < ActiveRecord::Base
  has_many :drawings

  def self.login(name, password)
    find_by_name_and_password(name, encrypt(password))
  end

  def self.register(params)
    return false unless params[:password] == params[:password1]

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
