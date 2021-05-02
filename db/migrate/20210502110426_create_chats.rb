class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.integer :user_id, null: false
      t.integer :partner_id, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end
