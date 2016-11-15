class AddLastPacketToDomains < ActiveRecord::Migration[5.0]
  def change
    add_column :domains, :last_updated_at, :timestamp
    add_index :domains, :last_updated_at
    add_column :domains, :plesk_created_date, :date
    add_column :domains, :last_packet, :jsonb
  end
end
