class AddShowToPost < ActiveRecord::Migration
  def change
    add_column :posts, :show, :boolean
  end
end
