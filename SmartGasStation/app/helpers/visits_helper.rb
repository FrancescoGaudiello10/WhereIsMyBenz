module VisitsHelper
    def get_implant_logo(query)
    	begin  
		    res = HTTParty.get(
            "https://api.qwant.com/api/search/images?q=#{query}%20logo",
            :query => {:output => 'json'}
        	)
        	return res["data"]["result"]["items"][0]["media"]
		rescue 
		    return ""
		end 
    end
end

