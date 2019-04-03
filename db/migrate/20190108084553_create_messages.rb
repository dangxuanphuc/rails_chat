class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :recipient_id
      t.integer :sender_id
      t.boolean :status, default: false

      t.timestamps
    end

    add_index :messages, :recipient_id
    add_index :messages, :sender_id
    add_index :messages, [:recipient_id, :sender_id], unique: true
  end
end
