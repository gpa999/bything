class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :tell, foreign_key: { to_table: :users }
      t.text :text
      t.timestamps
    end
  end
end
