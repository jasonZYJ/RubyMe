class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.integer :category_id
      t.integer :user_id
      t.integer :status

      t.timestamps
    end
  end
end
