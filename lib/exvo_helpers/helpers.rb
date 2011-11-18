module Exvo

  module Helpers

    # CDN BUNDLES

    def self.cdn_uri
      "http://#{cdn_host}"
    end

    def self.cdn_host
      @@cdn_host ||= ENV['CDN_HOST'] || default_opts[env.to_sym][:cdn_host]
    end

    def self.cdn_host=(host)
      @@cdn_host = host
    end


    # CFS

    def self.cfs_uri
      "http://#{cfs_host}"
    end

    def self.cfs_host
      @@cfs_host ||= ENV['CFS_HOST'] || default_opts[env.to_sym][:cfs_host]
    end

    def self.cfs_host=(host)
      @@cfs_host = host
    end


    # DESKTOP

    def self.desktop_uri
      "http://#{desktop_host}"
    end

    def self.desktop_host
      @@desktop_host ||= ENV['DESKTOP_HOST'] || default_opts[env.to_sym][:desktop_host]
    end

    def self.desktop_host=(host)
      @@desktop_host = host
    end


    # THEMES

    def self.themes_uri
      "http://#{themes_host}"
    end

    def self.themes_host
      @@themes_host ||= ENV['THEMES_HOST'] || default_opts[env.to_sym][:themes_host]
    end

    def self.themes_host=(host)
      @@themes_host = host
    end


    # AUTH

    # pass-in to the ExvoAuth gem
    def self.auth_uri
      if defined?(ExvoAuth::Config) and ExvoAuth::Config.respond_to?('uri')
        ExvoAuth::Config.uri
      else
        raise "Exvo.auth_uri method is available only when exvo-auth gem is available"
      end
    end

    def self.auth_host
      if defined?(ExvoAuth::Config) and ExvoAuth::Config.respond_to?('host')
        ExvoAuth::Config.host
      else
        raise "Exvo.auth_host method is available only when exvo-auth gem is available"
      end
    end


    # ENV

    def self.env
      @@env ||= Rails.env if defined?(Rails)
      @@env ||= Merb.env if defined?(Merb)
      @@env
    end

    def self.env=(env)
      @@env = env
    end


    private

    def self.default_opts
      {
        :production => {
          :cdn_host => 'cdn.exvo.com',
          :cfs_host => 'cfs.exvo.com',
          :desktop_host => 'www.exvo.com',
          :themes_host => 'themes.exvo.com'
        },
        :staging => {
          :cdn_host => 'staging.cdn.exvo.com',
          :cfs_host => 'staging.cfs.exvo.com',
          :desktop_host => 'www.exvo.co',
          :themes_host => 'staging.themes.exvo.com'
        },
        :development => {
          :cdn_host => 'www.exvo.local',
          :cfs_host => 'cfs.exvo.local',
          :desktop_host => 'www.exvo.local',
          :themes_host => 'themes.exvo.local'
        },
        :test => {
          :cdn_host => 'www.exvo.local',
          :cfs_host => 'cfs.exvo.local',
          :desktop_host => 'www.exvo.local',
          :themes_host => 'themes.exvo.local'
        }
      }
    end

  end

end
