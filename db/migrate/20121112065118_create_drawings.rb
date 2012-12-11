class CreateDrawings < ActiveRecord::Migration
  def change
    create_table :drawings do |t|
      t.string :slug
      t.references :user

      t.timestamps
    end

    add_index :drawings, [ :user_id, :slug ], :unique => true, :name => 'drawings_user'
  end
end
