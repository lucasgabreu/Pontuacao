class CreateRanks < ActiveRecord::Migration[5.1]
  def change
    create_table :ranks do |t|
      t.string :data
      t.string :nome
      t.integer :codigo
      t.decimal :nota

      t.timestamps
    end
  end
end
