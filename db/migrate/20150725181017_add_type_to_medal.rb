class AddTypeToMedal < ActiveRecord::Migration
  def change
    add_column :medals, :type, :string
  end
end
