class UpsertsCharities
  def call(city, charities_json)
    categories = upsert_categories(charities_json)
    upsert_charities(city, charities_json, categories)
  end

  private

  def upsert_categories(charities)
    time = Time.zone.now
    category_attrs = charities.map { |c|
      {name: c["category"], last_fetched_at: time}
    }.uniq
    puts "Upserting #{category_attrs.size} categories"
    Category.upsert_all(category_attrs, unique_by: [:name])
    Category.all
  end

  def upsert_charities(city, charities, categories)
    charity_attrs = charities.map { |charity|
      {
        city_id: city.id,
        category_id: categories.find { |c| c.name == charity["category"] }&.id,
        name: charity["charityName"],
        ein: charity["ein"],
        mission_statement: charity["missionStatement"],
        zip_code: charity["zipCode"],
        accepting_donations: charity["acceptingDonations"] == 1,
        org_hunter_url: charity["url"],
        donation_url: charity["donationUrl"],
        web_site_url: charity["website"],
        last_fetched_at: Time.zone.now
      }
    }
    puts "Upserting #{charity_attrs.size} charities"

    Charity.upsert_all(charity_attrs, unique_by: [:city_id, :ein])
  end
end
