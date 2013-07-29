class DefaultStatus < ActiveRecord::Migration
  def change
  	change_column :basic_tasks, :status, :string, :default => true
  end
end
