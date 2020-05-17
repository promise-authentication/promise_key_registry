class CreateKeyPairs < ActiveRecord::Migration[6.0]
  def change
    create_table :key_pairs do |t|
      t.string :private_key
      t.string :public_key

      t.timestamps

      t.index :public_key
    end
  end
end
