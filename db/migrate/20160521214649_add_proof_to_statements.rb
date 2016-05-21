class AddProofToStatements < ActiveRecord::Migration[5.0]
  def change
    add_column :statements, :proof, :string
  end
end
