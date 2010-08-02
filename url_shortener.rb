module UrlShortener
  URL_CHARS = ('0'..'9').to_a + %w(b c d f g h j k l m n p q r s t v w x y z)
  URL_BASE = URL_CHARS.size	

  def self.included(base)
    base.before_create :generate_key
  end

  def generate_key
    self.key = generate_url(self.id)
  end

  def generate_url(id)
    result = ''
    while id != 0
      r = id % URL_BASE
      id = (id - r) / URL_BASE
      result << URL_CHARS[r]
    end
    result
  end
end
