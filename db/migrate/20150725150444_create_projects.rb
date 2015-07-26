class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :population
      t.integer :cash_flow
      t.integer :income
      t.integer :money
      t.integer :satis_people_1
      t.integer :satis_people_2
      t.integer :satis_people_3
      t.integer :satis_people_4
      t.integer :satis_work_1
      t.integer :satis_work_2
      t.integer :satis_work_3
      t.integer :satis_work_4

      t.timestamps null: false
    end
  end
end
