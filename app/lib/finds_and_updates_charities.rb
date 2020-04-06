class FindsAndUpdatesCharities
  def call(city, charities_json)
    categories = update_categories(charities_json)
    update_charities(city, charities_json, categories)
  end

  private

  def update_categories(charities_json)
    category_names = charities_json.map { |c| c["category"] }.uniq
    puts "Finding and updating #{category_names.size} categories"
    category_names.map do |category_name|
      Category.find_or_initialize_by(name: category_name).tap do |category|
        category.update!(last_fetched_at: Time.zone.now)
      end
    end
  end

  def update_charities(city, charities_json, categories)
    puts "Updating #{charities_json.size} charities"
    charities_json.each do |charity|
      Charity.find_or_initialize_by(
        city: city,
        ein: charity["ein"]
      ).update!(
        category: categories.find { |c| c.name == charity["category"] },
        name: charity["charityName"],
        mission_statement: charity["missionStatement"],
        zip_code: charity["zipCode"],
        accepting_donations: charity["acceptingDonations"] == 1,
        org_hunter_url: charity["url"],
        donation_url: charity["donationUrl"],
        web_site_url: charity["website"],
        last_fetched_at: Time.zone.now
      )
    end
  end
end
