class ChangeProductsUrlToAsin < ActiveRecord::Migration
  def change
    rename_column("products", "url", "asin")
    change_column("products", "asin", :string)
  end
end
