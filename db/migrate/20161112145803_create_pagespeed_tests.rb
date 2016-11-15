class CreatePagespeedTests < ActiveRecord::Migration[5.0]
  def change
    create_table :pagespeed_tests do |t|
      t.references :domain, foreign_key: true
      t.datetime :timestamp
      t.integer :speed_score
      t.integer :usability_score
      t.boolean :has_viewport
      t.jsonb :test

      t.timestamps
    end
  end
end
