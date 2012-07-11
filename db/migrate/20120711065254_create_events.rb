class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :date
      t.datetime :end_date
      t.timestamps
    end
  end
end
