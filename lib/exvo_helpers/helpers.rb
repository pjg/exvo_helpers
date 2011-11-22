module Exvo

  module Helpers

    # Dynamically define class methods
    class << self

      %w(cdn cfs desktop themes).each do |service|

        # def self.cdn_uri
        #   "http://#{cdn_host}"
        # end
        define_method "#{service}_uri" do
          "http://#{ send("#{service}_host") }"
        end

        # def self.cdn_host
        #   @@cdn_host ||= ENV['CDN_HOST'] || default_opts[env.to_sym][:cdn_host]
        # end
        define_method "#{service}_host" do
          # poor man's metaprogramming memoization - if it's defined (and not nil!) return it; if not, set it
          if class_variable_defined?("@@#{service}_host") and class_variable_get("@@#{service}_host")
            class_variable_get("@@#{service}_host")
          else
            host = ENV["#{service.upcase}_HOST"] || default_opts[env.to_sym]["#{service}_host".to_sym]
            class_variable_set("@@#{service}_host", host)
          end
        end

        # def self.cdn_host=(host)
        #   @@cdn_host = host
        # end
        define_method "#{service}_host=" do |host|
          class_variable_set("@@#{service}_host", host)
        end

      end

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
