class CreateSurvivors < ActiveRecord::Migration[5.1]
  def change
    create_table :survivors do |t|
      t.string :name, null: false
      t.date :birth_date, null: false
      t.integer :gender, null: false
      t.boolean :contaminated, null: false, default: false
      t.jsonb :last_location, null:false, default: {lat: "", lng: ""}

      t.timestamps null: false
    end

    add_index :survivors, :last_location, using: :gin
  end
end
