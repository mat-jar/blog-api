require 'faraday'
require 'faraday/net_http'
Faraday.default_adapter = :net_http

class SentenceSearcher

  def initialize(word)
    @word = word
  end

  def get_sentences
    response = HTTParty.get('http://api.openweathermap.org/data/2.5/weather?zip=' + @zip + ',us&appid=[YOUR API KEY HERE]')
    response["main"]["humidity"]
  end
end


conn = Faraday.new(
  url: 'http://httpbingo.org',
  params: {param: '1'},
  headers: {'Content-Type' => 'application/json'}
)

response = conn.post('/post') do |req|
  req.params['limit'] = 100
  req.body = {query: 'chunky bacon'}.to_json
end
# => POST http://httpbingo.org/post?param=1&limit=100

https://en.wikipedia.org/w/api.php?action=query&format=json&list=search&srsearch=apple
