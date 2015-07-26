class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :medals, :type, :type_name
  end
end
