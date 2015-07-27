class AddYearToStudent < ActiveRecord::Migration
  def change
    add_column :students, :year, :string
  end
end
