class CreateComplaints < ActiveRecord::Migration[5.1]
  def change
    create_table :complaints do |t|
      t.integer :complainer_id , null: false
      t.integer :contaminated_id, null: false

      t.timestamps null: false
    end

    add_foreign_key :complaints, :survivors, column: :complainer_id, primary_key: :id, index: true
    add_foreign_key :complaints, :survivors, column: :contaminated_id, primary_key: :id, index: true
    add_index :complaints, [:complainer_id, :contaminated_id]
  end
end
