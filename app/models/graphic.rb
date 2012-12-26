class Graphic < ActiveRecord::Base
  attr_accessible :drawing, :type, :user, :value
  belongs_to :drawing

  def self.add(user_id, graphic_id, value)
    new.tap do |g|
      g.user_id = user_id
      g.value = value
      g.z = (Graphic.maximum(:z) || 0) + 1
      # save twice because we need to put the graphic id in the complete JSON
      g.save

      json = ActiveSupport::JSON.decode value
      json['graphic_id'] = g.id
      g.value = ActiveSupport::JSON.encode json
      g.save
    end
  end

  def self.complete
    "[#{where('value is not null')
        .order(:z)
        .inject([]) do |list, g|
          list << g.value
        end * ','}]"
  end

  def modify(value, z = nil)
    self.value = value
    self.z = z if z
    self
  end
end
