class CreateDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :destinations do |t|
      t.string :location
      t.string :city
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
