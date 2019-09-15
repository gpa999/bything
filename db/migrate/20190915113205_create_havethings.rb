class CreateHavethings < ActiveRecord::Migration[5.2]
  def change
    create_table :havethings do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.integer :price
      t.timestamps
    end
  end
end
