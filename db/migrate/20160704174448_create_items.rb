class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :notes
      t.integer :room_id
    end
  end
end
