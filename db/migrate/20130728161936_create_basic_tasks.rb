class CreateBasicTasks < ActiveRecord::Migration
  def change
    create_table :basic_tasks do |t|
      t.string    :description, :limit => 600
      t.string    :priority
      t.string	  :status, :default => 'completed'
      t.string	  :type 
      t.timestamps 
      t.timestamp :completed_at
    end
  end
end
