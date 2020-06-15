class AddColorToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :color, :string, default: "005a55"

    add_reference :questions, :author, foreign_key: { to_table: :users }
  end
end
