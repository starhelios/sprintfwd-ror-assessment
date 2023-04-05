class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :city
      t.string :state
      t.string :country 

      t.string :first_name, null: false
      t.string :last_name, null: false
      t.references :team, null: false, foreign_key: true
      t.timestamps
    end
  end
end
