namespace :flights do
  task import_arrivals: :environment do
    Anemone.crawl("https://www.cph.dk/en/flight-information/arrivals") do |anemone|
      create_flights('arrivals', anemone)
    end
  end
  task import_departures: :environment do
    Anemone.crawl("https://www.cph.dk/en/flight-information/departures") do |anemone|
      create_flights('departures', anemone)
    end
  end
end

def create_flights(type, anemone)
  results = []
  anemone.on_every_page do |page|
    elm = Nokogiri::HTML(page.body)
    elm.css(".stylish-table__row--body").each do |row|
      flight = {}
      flight[:direction_type] = type
      flight[:airline] = row.css(".v--desktop-only")[1].try(:text).try(:strip)
      flight[:exact_time] = row.css(".flights__table__col--time").text.try(:strip).split("\n")[0].try(:strip)
      flight[:expected_time] = row.css(".flights__table__col--time").text.try(:strip).split("\n")[1].try(:strip)
      destination = row.css(".flights__table__col--destination").text.try(:strip).split("\n")
      flight[:destination] = destination[0].try(:strip)
      flight[:status] = row.css(".stylish-table__cell")[-2].try(:text).try(:strip)
      results << flight
    end
    Flight.create(results)
    abort
  end
end
