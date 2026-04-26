class AddCategoryAndKanaToOshis < ActiveRecord::Migration[8.1]
  def change
    add_column :oshis, :category, :string
    add_column :oshis, :kana, :string
  end
end
