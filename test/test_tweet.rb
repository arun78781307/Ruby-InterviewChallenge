require 'test/unit'
require_relative './../lib/ruby/tweet'

class TweetTest < Test::Unit::TestCase

  def setup
    @tweet = Tweet.new({'id' => 123, 'name' => 'rubydev', 'screen_name' => 'rubydev'}, "sample tweet", "Tue Nov 03 08:06:32 +0000 2015")
  end 
  
  def teardown
  
  end 
  
  def test_user
    assert_equal(String, @tweet.name.class)
	assert_not_equal(nil, @tweet.name)
	assert_equal('rubydev', @tweet.name)
  end 
  
  def test_date
    assert_equal(Date, @tweet.date.class)
	assert_not_equal(nil, @tweet.date)
  end 
  
  def test_text
    assert_equal(String, @tweet.text.class)
	assert_not_equal(nil, @tweet.text)
	assert_equal('sample tweet', @tweet.text)
  end 
  
end 