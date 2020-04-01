class AddCitiesAndCharities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :name, null: false
      t.string :state, null: false

      t.timestamps default: -> { "CURRENT_TIMESTAMP" }

      t.index [:name, :state], unique: true
    end

    create_table :categories do |t|
      t.string :name, null: false

      t.timestamps default: -> { "CURRENT_TIMESTAMP" }

      t.index [:name], unique: true
    end

    create_table :charities do |t|
      t.references :city, null: false, foreign_key: true
      t.references :category, foreign_key: true

      t.string :name, null: false
      t.string :ein, null: false
      t.string :mission_statement
      t.string :zip_code, null: false
      t.boolean :accepting_donations
      t.string :org_hunter_url, null: false
      t.string :donation_url, null: false
      t.string :web_site_url, null: false

      t.timestamps default: -> { "CURRENT_TIMESTAMP" }

      t.index [:city_id, :ein], unique: true
    end
  end
end
