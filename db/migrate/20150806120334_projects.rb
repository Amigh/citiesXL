class Projects < ActiveRecord::Migration
  def change
    add_column :projects, :satis_shop, :integer
    add_column :projects, :satis_env, :integer
    add_column :projects, :satis_services, :integer
    add_column :projects, :satis_freight, :integer
    add_column :projects, :satis_trafic, :integer
  end
end
