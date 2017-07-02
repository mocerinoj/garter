class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.references :domain, foreign_key: true
      t.string :activity
      t.jsonb :data
      t.datetime :timestamp, null: false, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
    add_index :events, :activity
  end
end
