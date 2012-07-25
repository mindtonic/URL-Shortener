module UrlShortener
  URL_CHARS = ('0'..'9').to_a + %w(b c d f g h j k l m n p q r s t v w x y z)
  URL_BASE = URL_CHARS.size

  def self.included(base)
    base.before_create :generate_passkey
    base.scope :by_passkey, lambda { |passkey| where(:passkey => passkey) }
  end

  def to_param
    self.passkey || self.id
  end

  def generate_key
    self.passkey = generate_passkey(self.id)
  end

  def generate_passkey(id)
    passkey = ''
    while id != 0
      r = id % URL_BASE
      id = (id - r) / URL_BASE
      passkey << URL_CHARS[r]
    end
    passkey
  end
end
