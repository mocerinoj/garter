class CreateDomainLookups < ActiveRecord::Migration[5.0]
  def change
    create_table :domain_lookups do |t|
      t.references :domain, foreign_key: true
      t.datetime :timestamp
      t.jsonb :nameservers
      t.string :a_record
      t.string :mx_record

      t.timestamps
    end
  end
end
