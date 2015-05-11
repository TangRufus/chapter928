class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :email
      t.integer :price
      t.datetime :scene
      t.string :number

      t.timestamps null: false
    end
  end
end
