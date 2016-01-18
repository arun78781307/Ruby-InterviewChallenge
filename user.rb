class User

  attr_reader :id, :name, :screen_name

  def initialize(opts={})
    @id          = opts['id']          if opts['id']
    @name        = opts['name']        if opts['name']
    @screen_name = opts['screen_name'] if opts['screen_name']
  end

end