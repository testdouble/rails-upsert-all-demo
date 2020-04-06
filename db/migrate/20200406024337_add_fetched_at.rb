class AddFetchedAt < ActiveRecord::Migration[6.0]
  def change
    change_table :categories do |t|
      t.datetime :last_fetched_at
    end

    change_table :charities do |t|
      t.datetime :last_fetched_at
    end
  end
end
