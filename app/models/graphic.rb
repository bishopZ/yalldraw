class Graphic < ActiveRecord::Base
  attr_accessible :drawing, :type, :user, :value
  belongs_to :drawing

  def self.add(user_id, graphic_id, value)
    new.tap do |g|
      g.user_id = user_id
      g.value = value
      g.z = (Graphic.maximum(:z) || 0) + 1
      g.save

      json = ActiveSupport::JSON.decode value
      json['graphic_id'] = g.id
      g.value = ActiveSupport::JSON.encode json
      g.save
    end
  end

  def self.complete
    "[#{all.inject([]){ |list, g| list << g.value } * ','}]"
  end

  def self.modify(graphic_id, value, z)
    find(graphic_id).tap do |g|
      g.value = value
      g.z = z
    end
  end

  def self.remove(graphic_id)
    find(graphic_id)
      .destroy
  end
end
