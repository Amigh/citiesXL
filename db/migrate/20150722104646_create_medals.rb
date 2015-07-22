class CreateMedals < ActiveRecord::Migration
  def change
    create_table :medals do |t|
      t.string :name
      t.string :description
      t.integer :score
      t.string :image

      t.timestamps null: false
    end
  end
end
