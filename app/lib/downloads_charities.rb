class DownloadsCharities
  PAGE_SIZE = 1000
  BASE_URL = "https://data.orghunter.com/v1/charitysearch"

  def call(city)
    download(city: city)
  end

  private

  def download(city:, start: 0)
    uri = URI(BASE_URL + query_string(city: city, start: start))
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)
      response = http.request(req)
      json = JSON.parse(response.body)
      raise json["msg"] unless json["code"] == "200"
      if (results = json["data"])
        if (next_start = next_page_starts_at(results.sample))
          results += download(city: city, start: next_start)
        end
        return results
      end
    end
  end

  def query_string(city:, start: 0)
    raise "ENV var ORG_HUNTER_API_KEY required!" unless ENV.key?("ORG_HUNTER_API_KEY")
    {
      user_key: ENV["ORG_HUNTER_API_KEY"],
      rows: PAGE_SIZE,
      city: city.name,
      state: city.state,
      start: start
    }.reduce(nil) { |memo, (k, v)|
      "#{memo ? "#{memo}&" : "?"}#{k}=#{v}"
    }
  end

  def next_page_starts_at(sample)
    return unless sample
    if sample["start"] + sample["rows"] < sample["recordCount"]
      sample["start"] + sample["rows"]
    end
  end
end
