class User < ActiveRecord::Base
  attr_accessible :name, :password

  validates_uniqueness_of :name
  has_many :drawings

  def self.login(name, password)
    find_by_name_and_password(name, encrypt(password))
  end

  def self.register(name, password, password_again)
    # TODO: these should be validated
    raise(ArgumentError, 'Passwords do not match') unless password == password_again
    raise(ArgumentError, 'Name too short') if name.size < 3
    raise(ArgumentError, "Cannot duplicate user with name: #{name}") if User.find_by_name name

    new.tap do |u|
      u.name = name
      u.password = encrypt password
      u.save
    end
  end

  # TODO: fix this
  def self.encrypt(value)
    Digest::SHA1.base64digest('cheesepotatoe' + value)
  end
end
