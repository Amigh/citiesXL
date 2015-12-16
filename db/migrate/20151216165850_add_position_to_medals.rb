class AddPositionToMedals < ActiveRecord::Migration
  def change
    add_column :medals, :position, :integer
  end
end
