require_relative 'user'
require 'date'

class Tweet < User
  attr_reader :user, :text, :date

  def initialize(user, text, date)
    super(user)
    @text = text
    @date = Date.parse date
  end

  def to_s
    "User: #{name}\nDate: #{date}\nTweet: #{text}"
  end
end 