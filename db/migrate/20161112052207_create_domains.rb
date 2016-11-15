class CreateDomains < ActiveRecord::Migration[5.0]
  def change
    create_table :domains do |t|
      t.references :plesk_server, foreign_key: true
      t.inet :ip_address
      t.boolean :is_ssl
      t.string :ftp_username
      t.string :ftp_password
      t.string :status
      t.integer :plesk_id
      t.string :hosting_type
      t.string :name
      t.string :redirect_to

      t.timestamps
    end
    add_index :domains, :name
  end
end
