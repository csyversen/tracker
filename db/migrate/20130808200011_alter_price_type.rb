class AlterPriceType < ActiveRecord::Migration
  def change
    change_column("prices", "price", :decimal, :precision => 8, :scale => 2)
  end
end
