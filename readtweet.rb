require 'faraday'
require 'yaml'
require 'json'
require 'oauth'

require_relative 'tweet'

def oauth
  config['oauth']
end

def config
  @config ||= YAML::load_file('config.yml')
end
def endpoint
  config['defaults']['endpoint']
end
def request_tweet()
conn = Faraday::Connection.new(endpoint, :ssl => {:ca_path => './server.crt'})
conn.get do |req|
  req.url endpoint
  req.headers['Authorization'] = 'OAuth'
  req.headers['oauth_consumer_key'] = oauth['oauth_consumer_key']
  req.headers['oauth_nonce'] =  oauth['oauth_nonce']
  req.headers['oauth_signature'] =  oauth['oauth_signature']
  req.headers['oauth_signature_method'] = oauth['oauth_signature_method']
  req.headers['oauth_timestamp'] = oauth['oauth_timestamp']
  req.headers['oauth_token'] = oauth['oauth_token']
  req.headers['oauth_version'] = oauth['oauth_version']
end
end

def marshall_json(data)
  Tweet.new(data['user'], data['text'], data['created_at'])
end

begin
  response = request_tweet
  parsed_response = JSON.parse(response)
rescue => er
  p er.message
  puts "Authentication might have failed, so reading dumped sample.json"
  parsed_response = []
  file = File.open("sample.json")
  file.each_line do |line|
    parsed_response << JSON.parse(line)
  end

  tweets = []
  parsed_response.each do |data|
    next if data['delete']
    tweets << marshall_json(data)
  end


  tweets.each do |tweet|
    puts '-'*50
    puts tweet.to_s
  end
end

