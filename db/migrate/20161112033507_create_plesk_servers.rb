class CreatePleskServers < ActiveRecord::Migration[5.0]
  def change
    create_table :plesk_servers do |t|
      t.string :name
      t.string :host
      t.inet :primary_ip
      t.string :plesk_version

      t.timestamps
    end
  end
end
