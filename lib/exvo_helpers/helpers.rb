module Exvo

  # CFS

  def self.cfs_uri
    "http://#{cfs_host}"
  end

  def self.cfs_host
    @@cfs_host ||= ENV['CFS_HOST']
    @@cfs_host ||=
      case(env)
      when 'production'
        'cfs.exvo.com'
      when 'staging'
        'staging.cfs.exvo.com'
      else
        'cfs.exvo.local'
      end

    @@cfs_host
  end

  def self.cfs_host=(host)
    @@cfs_host = host
  end

  # DESKTOP

  def self.desktop_uri
    "http://#{desktop_host}"
  end

  def self.desktop_host
    @@desktop_host ||= ENV['DESKTOP_HOST']
    @@desktop_host ||=
      case(env)
      when 'production'
        'www.exvo.com'
      when 'staging'
        'www.exvo.co'
      else
        'www.exvo.local'
      end

    @@desktop_host
  end

  def self.desktop_host=(host)
    @@desktop_host = host
  end

  # THEMES

  def self.themes_uri
    "http://#{themes_host}"
  end

  def self.themes_host
    @@themes_host ||= ENV['THEMES_HOST']
    @@themes_host ||=
      case(env)
      when 'production'
        'themes.exvo.com'
      when 'staging'
        'staging.themes.exvo.com'
      else
        'themes.exvo.local'
      end

    @@themes_host
  end

  def self.themes_host=(host)
    @@themes_host = host
  end

  # ENV

  def self.env
    @@env ||= Rails.env if defined?(Rails)
    @@env ||= Merb.env if defined?(Merb)
    @@env
  end
end
