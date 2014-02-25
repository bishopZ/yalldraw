class Drawing < ActiveRecord::Base
  belongs_to :user
  has_many :graphics

  def self.from_user(user)
    where('user_id = ?', user.id)
  end

  def self.create_blank(user, slug)
    user.drawings.create slug: slug
  end
end
