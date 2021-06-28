class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.string :api_token
      t.string :device_token
      t.datetime :expire_at
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
