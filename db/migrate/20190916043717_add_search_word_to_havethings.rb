class AddSearchWordToHavethings < ActiveRecord::Migration[5.2]
  def change
    add_column :havethings, :search_word, :text
  end
end
