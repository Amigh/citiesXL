class CreateMedalizations < ActiveRecord::Migration
  def change
    create_table :medalizations do |t|
      t.integer :student_id
      t.integer :medal_id

      t.timestamps null: false
    end
  end
end
