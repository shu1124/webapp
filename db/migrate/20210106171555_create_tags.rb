class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name, null: false

      t.timestamps
      t.index :name, unique: true
    end

  end
end