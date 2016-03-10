class CreatePostgresqlSearches < ActiveRecord::Migration
  def change
    create_table :postgresql_searches do |t|
      t.references :searchable, :polymorphic => true, index: true
      t.tsvector :search_data

      t.timestamps null: false
    end

    add_index :postgresql_searches, :search_data, using: "gin"
  end

end
