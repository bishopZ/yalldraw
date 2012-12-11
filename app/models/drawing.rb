class Drawing < ActiveRecord::Base
  attr_accessible :slug, :user

  belongs_to :user
  has_many :graphics

  validates :slug, :user, :presence => true

  def self.from_user(user)
    where('user_id = ?', user.id)
  end

  def self.create_blank(user, slug)
    user.drawings.create slug: slug
  end
end
