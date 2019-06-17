class CreateSurvivorsItems < ActiveRecord::Migration[5.1]
  def change
    create_table :survivors_items do |t|
      t.integer :survivor_id, null: false
      t.integer :item, null: false
      t.integer :amount, null: false

      t.timestamps null: false
    end

    add_foreign_key :survivors_items, :survivors, column: :survivor_id, index: true
  end
end
