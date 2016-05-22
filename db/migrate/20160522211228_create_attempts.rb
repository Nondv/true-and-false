class CreateAttempts < ActiveRecord::Migration[5.0]
  def change
    create_table :attempts do |t|

      t.timestamps
    end
  end
end
