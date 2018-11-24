class CreateSomas < ActiveRecord::Migration[5.1]
  def change
    create_table :somas do |t|
      t.decimal :total
      t.string :nome
      t.integer :codigo_user

      t.timestamps
    end
  end
end
