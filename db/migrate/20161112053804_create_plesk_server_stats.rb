class CreatePleskServerStats < ActiveRecord::Migration[5.0]
  def change
    create_table :plesk_server_stats do |t|
      t.references :plesk_server, foreign_key: true
      t.datetime :timestamp
      t.integer :domains
      t.integer :active_domains
      t.string :plesk_version
      t.jsonb :load_avg
      t.jsonb :mem
      t.jsonb :diskspace

      t.timestamps
    end
  end
end
