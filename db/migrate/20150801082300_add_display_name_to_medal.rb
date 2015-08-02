class AddDisplayNameToMedal < ActiveRecord::Migration
  def change
    add_column :medals, :display_name, :string
  end
end
