CITIES = [
  {name: "Columbus", state: "OH"}
]

CITIES.each do |attrs|
  City.find_or_create_by!(attrs)
end
