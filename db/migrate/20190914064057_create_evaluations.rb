class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.references :user, foreign_key: true
      t.references :rate, foreign_key: { to_table: :users }
      t.integer :value
      t.timestamps
      t.index [:user_id, :rate_id], unique: true
    end
  end
end
