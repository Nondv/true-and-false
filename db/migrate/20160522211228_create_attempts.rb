class CreateAttempts < ActiveRecord::Migration[5.0]
  def change
    create_table :attempts do |t|
      t.integer :user_id, null: false
      t.integer :statement_id, null: false
      t.boolean :success, null: false

      t.timestamps
    end

    add_index :attempts, :user_id
    add_index :attempts, :statement_id
  end
end
