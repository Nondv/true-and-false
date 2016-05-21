class CreateStatements < ActiveRecord::Migration[5.0]
  def change
    create_table :statements do |t|
      t.text :ru
      t.text :ru_explanation
      t.integer :points, null: false
      t.boolean :value, null: false

      t.timestamps
    end
  end
end
