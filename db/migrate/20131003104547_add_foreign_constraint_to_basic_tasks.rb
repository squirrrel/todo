class AddForeignConstraintToBasicTasks < ActiveRecord::Migration
  def change
  	 add_reference :basic_tasks, :user, index: true
  end
end
