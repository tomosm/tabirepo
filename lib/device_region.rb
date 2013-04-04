class DeviceRegion
      
  SMART_TABLET = 2;
  OTHER = 1;
  USER_AGENTS = [
        'iPhone',         # Apple iPhone
        'iPad',           # Apple iPad
        'iPod',           # Apple iPod touch
        'Android', # 1.5+ Android
        'Android.*Mobile', # 1.5+ Android
        'Windows.*Phone', # Windows Phone
        'dream',          # Pre 1.5 Android
        'CUPCAKE',        # 1.5+ Android
        'blackberry9500', # Storm
        'blackberry9530', # Storm
        'blackberry9520', # Storm v2
        'blackberry9550', # Storm v2
        'blackberry9800', # Torch
        'webOS',          # Palm Pre Experimental
        'incognito',      # Other iPhone browser
        'webmate'         # Other iPhone browser
  ]

  def self.getValue(user_agent)
    regexp = Regexp.new(USER_AGENTS.join("|"), "i")
    if (regexp.match(user_agent))
      return SMART_TABLET
    else 
      return OTHER
    end
  end
end
