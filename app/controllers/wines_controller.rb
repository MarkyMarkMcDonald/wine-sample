class WinesController < ApplicationController
  def create
    wine_names = params["wine-list"].split("\n").map(&:strip)
    @wines = wine_names.map do |name|
      response = HTTParty.get("http://services.wine.com/api/beta2/service.svc/json/catalog?apikey=cae7f4e3edbe3608d44bdf0c1280af9b", {query: {term: name}})
      JSON.parse(response.body)
    end
    puts @wines
  end
end