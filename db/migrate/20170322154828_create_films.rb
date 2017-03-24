class CreateFilms < ActiveRecord::Migration[5.0]
  def change
    enable_extension "hstore" unless extension_enabled?('hstore')
    create_table :films do |t|
      t.string :title
      t.text :description
      t.string :url_slug
      t.integer :year
      t.integer :related_film_ids, array: true, default: []
      t.decimal :average_rating
      t.hstore :ratings, default: '', null: false
      t.timestamps
    end
  end
end
