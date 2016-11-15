class CreateDomainStats < ActiveRecord::Migration[5.0]
  def change
    create_table :domain_stats do |t|
      t.references :domain, foreign_key: true
      t.jsonb :stat
      t.jsonb :disk_usage
      t.bigint :total_size
      t.datetime :timestamp

      t.timestamps
    end
  end
end
