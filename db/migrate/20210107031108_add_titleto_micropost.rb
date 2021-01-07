class AddTitletoMicropost < ActiveRecord::Migration[6.0]
    def change
      add_column :microposts, :title, :string, null: false
      add_column :microposts, :time, :integer, null: false
    end
end
