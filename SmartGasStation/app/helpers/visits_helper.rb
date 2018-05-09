module VisitsHelper
    def get_implant_logo(query)
        res = HTTParty.get(
            "https://api.qwant.com/api/search/images?q=#{query}%20logo",
            :query => {:output => 'json'}
        )
        return res["data"]["result"]["items"][0]["media"]
    end
end
