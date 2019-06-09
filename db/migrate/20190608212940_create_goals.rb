class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :detail, null: false
      t.integer :user_id, null: false
      t.boolean :public, null: false, default: true
      t.boolean :completed, null: false, default: false

      t.timestamps
    end

    add_index :goals, :user_id
    add_index :goals, :title
  end
end
