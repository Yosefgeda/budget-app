class AddColumnToSettlements < ActiveRecord::Migration[7.0]
  def change
    add_column :settlements, :group_id, :integer
  end
end
