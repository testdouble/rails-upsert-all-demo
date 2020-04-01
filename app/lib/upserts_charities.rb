class UpsertsCharities
  def initialize
    @downloads_charities = DownloadsCharities.new
  end

  def call
    City.all.each do |city|
      charities = @downloads_charities.call(city)
      categories = upsert_categories(charities)
      upsert_charities(city, charities, categories)
    end
  end

  private

  def upsert_categories(charities)
    category_attrs = charities.map { |c| {name: c["category"]} }.uniq
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
        web_site_url: charity["website"]
      }
    }

    Charity.upsert_all(charity_attrs, unique_by: [:city_id, :ein])
  end
end
