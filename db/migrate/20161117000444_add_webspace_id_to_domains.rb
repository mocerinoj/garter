class AddWebspaceIdToDomains < ActiveRecord::Migration[5.0]
  def change
    add_column :domains, :webspace_id, :integer
    add_column :domains, :domain_type, :string
  end
end
