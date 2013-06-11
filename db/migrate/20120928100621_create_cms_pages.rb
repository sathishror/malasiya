class CreateCmsPages < ActiveRecord::Migration
  def self.up
    create_table :cms_pages do |t|
      t.string :title
      t.string :attachement
      t.text :content
      t.string :location
      t.timestamps
    end
  end

  def self.down
    drop_table :cms_pages
  end
end
