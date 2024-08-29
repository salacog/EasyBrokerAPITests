require 'uri'
require 'json'
require 'net/http'

puts "Listed items: "

#there are 1104 items according to JSON response, we divide by 50 items per page, hence we have to do 23 iterations
for j in 1..23
	url = URI("https://api.stagingeb.com/v1/properties?page=#{j}&limit=50")
	#url = URI("https://api.stagingeb.com/v1/properties?page=1&limit=20")
	http = Net::HTTP.new(url.host, url.port)
	http.use_ssl = true

	request = Net::HTTP::Get.new(url)
	request["accept"] = 'application/json'
	request["X-Authorization"] = 'l7u502p8v46ba3ppgvj5y2aad50lb9'

	response = http.request(request).read_body
	parsed =  JSON.parse(response)
	for i in 0..49
		puts "-" + parsed['content'][i]['title']
	end
end