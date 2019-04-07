class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :recipient_id
      t.integer :sender_id
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
