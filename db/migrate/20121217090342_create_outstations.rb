class CreateOutstations < ActiveRecord::Migration
  def self.up
    create_table :outstations do |t|
      t.boolean :is_out_of_state
      t.boolean :is_official
      t.string :placename
      t.string :state
      t.string :country
      t.string :from_date
      t.string :to_date
      t.references :user
      t.string :purpose
      t.integer :total_expenditure
      t.string :cause_spending
      t.string :attachment
      t.string :status
      t.references :department
      t.timestamps
    end
  end

  def self.down
    drop_table :outstations
  end
end
