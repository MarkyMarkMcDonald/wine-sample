class WinesController < ApplicationController
  def create
    wine_names = params["wine-list"].split("\n").map(&:strip)
    @wine_search_results = wine_names.map do |name|
      response = HTTParty.get("http://services.wine.com/api/beta2/service.svc/json/catalog?apikey=cae7f4e3edbe3608d44bdf0c1280af9b", {query: {term: name}})
      JSON.parse(response.body)['Products']['List']
    end

    @wine_search_results.map! do |result_list|
      result_list.first
    end


    @wine_search_results.map! do |result|
      {
        name: result['Name'],
        retail_price: result['PriceRetail'],
        expert_rating: result['Ratings'].try(:[], 'HighestScore'),
      }
    end

  end
end
