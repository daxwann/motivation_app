class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.integer :author_id, null: false
      t.references :commentable, polymorphic: true, index: true

      t.timestamps
    end

    add_index :comments, :author_id
  end
end
