class CreateGraphics < ActiveRecord::Migration
  def change
    create_table :graphics do |t|
      t.references :drawing
      t.references :user
      t.integer :z
      t.text :value

      t.timestamps
    end

    add_index :graphics, [ :id, :drawing_id ], :unique => true, :name => 'graphics_key'
  end
end
