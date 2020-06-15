class ColorDefaultFix < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:users, :color, "#005a55")
  end
end
