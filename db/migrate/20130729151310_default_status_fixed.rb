class DefaultStatusFixed < ActiveRecord::Migration
  def change
  	change_column :basic_tasks, :status, :string, :default => 'open'
  end
end
