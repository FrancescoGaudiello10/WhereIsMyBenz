module VisitsHelper
    def get_implant_logo(query)
    	begin  
		    res = HTTParty.get(
            "https://api.qwant.com/api/search/images?q=#{query}%20logo",
            :query => {:output => 'json'}
        	)
        	return res["data"]["result"]["items"][0]["media"]
		rescue 
		    return "http://worldartsme.com/images/gas-station-logo-clipart-1.jpg"
		end 
    end
end

