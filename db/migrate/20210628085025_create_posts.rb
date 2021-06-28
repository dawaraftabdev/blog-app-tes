class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :sub_title, default: ''
      t.references :user, null: false
      t.timestamps
    end
  end
end
