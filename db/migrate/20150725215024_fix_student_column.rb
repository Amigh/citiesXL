class FixStudentColumn < ActiveRecord::Migration
  def change
    rename_column :students, :image, :avatar
  end
end
