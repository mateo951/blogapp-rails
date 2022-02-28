class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.database_authenticatable
      t.confirmable
      t.string :name
      t.string :photo
      t.text :bio
      t.integer :posts_counter, :default => false

      t.timestamps
    end
  end
end
