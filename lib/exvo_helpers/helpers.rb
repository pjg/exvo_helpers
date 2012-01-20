module Exvo

  module Helpers

    # Dynamically define class methods
    class << self

      %w(auth cdn cfs desktop themes blog contacts inbox music pics preview).each do |service|

        # def self.cdn_uri
        #   protocol = 'http://'
        #   protocol = 'https://' if service == "auth" && auth_require_ssl
        #   protocol = '//' if ["cdn", "cfs", "themes"].include?(service) && env.to_sym == :production
        #   protocol + cdn_host
        # end
        define_method "#{service}_uri" do
          protocol = 'http://'

          # explicit https for auth
          protocol = 'https://' if service == "auth" && send(:auth_require_ssl)

          # special link starting with '//' in production so that the webserver can choose between HTTP and HTTPS
          # but only for those apps/services that have proper SSL support (i.e. valid certificates)
          protocol = '//' if ["cdn", "cfs", "themes"].include?(service) && env.to_sym == :production

          protocol + send("#{service}_host")
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

    # Dynamically define class methods
    class << self

      %w(debug require_ssl).each do |option|

        # def self.auth_debug
        #   return @@auth_debug if defined?(@@auth_debug) && !@@auth_debug.nil?
        #   @@auth_debug = (ENV['AUTH_DEBUG'] == 'true') || default_opts[env.to_sym][:auth_debug]
        # end
        define_method "auth_#{option}" do
          if class_variable_defined?("@@auth_#{option}") and !class_variable_get("@@auth_#{option}").nil?
            class_variable_get("@@auth_#{option}")
          else
            value = (ENV["AUTH_#{option.upcase}"] == 'true') || default_opts[env.to_sym]["auth_#{option}".to_sym]
            class_variable_set("@@auth_#{option}", value)
          end
        end

        # def self.auth_debug=(debug)
        #   @@auth_debug = debug
        # end
        define_method "auth_#{option}=" do |value|
          class_variable_set("@@auth_#{option}", value)
        end

      end

    end


    # ENV

    # by default fall back to production; this way the omniauth-exvo's gem specs can pass
    # (they depend on this gem and on env, but nor Rails nor Merb is undefined there)
    def self.env
      @@env ||= Rails.env if defined?(Rails)
      @@env ||= Merb.env if defined?(Merb)
      @@env ||= 'production'
    end

    def self.env=(env)
      @@env = env
    end


    private

    def self.default_opts
      {
        :production => {
          :auth_debug => false,
          :auth_host => 'auth.exvo.com',
          :auth_require_ssl => true,
          :cdn_host => 'd33gjlr95u9pgf.cloudfront.net', # cloudfront.net so we can use https (cdn.exvo.com via https does not work properly)
          :cfs_host => 'cfs.exvo.com',
          :desktop_host => 'www.exvo.com',
          :themes_host => 'themes.exvo.com',
          :blog_host => 'blog.exvo.com',
          :contacts_host => 'contacts.exvo.com',
          :inbox_host => 'inbox.exvo.com',
          :music_host => 'music.exvo.com',
          :pics_host => 'pics.exvo.com',
          :preview_host => 'preview.exvo.com'
        },
        :staging => {
          :auth_debug => false,
          :auth_host => 'staging.auth.exvo.com',
          :auth_require_ssl => false,
          :cdn_host => 'd1by559a994699.cloudfront.net',
          :cfs_host => 'staging.cfs.exvo.com',
          :desktop_host => 'www.exvo.co',
          :themes_host => 'staging.themes.exvo.com',
          :blog_host => 'staging.blog.exvo.com',
          :contacts_host => 'exvo-contacts-staging.heroku.com',
          :inbox_host => 'exvo-inbox-staging.heroku.com',
          :music_host => 'exvo-music-staging.heroku.com',
          :pics_host => 'exvo-pictures-staging.heroku.com',
          :preview_host => 'staging.preview.exvo.com'
        },
        :development => {
          :auth_debug => false,
          :auth_host => 'auth.exvo.local',
          :auth_require_ssl => false,
          :cdn_host => 'www.exvo.local',
          :cfs_host => 'cfs.exvo.local',
          :desktop_host => 'www.exvo.local',
          :themes_host => 'themes.exvo.local',
          :blog_host => 'blog.exvo.local',
          :contacts_host => 'contacts.exvo.local',
          :inbox_host => 'inbox.exvo.local',
          :music_host => 'music.exvo.local',
          :pics_host => 'pics.exvo.local',
          :preview_host => 'preview.exvo.local'
        },
        :test => {
          :auth_debug => false,
          :auth_host => 'auth.exvo.local',
          :auth_require_ssl => false,
          :cdn_host => 'www.exvo.local',
          :cfs_host => 'cfs.exvo.local',
          :desktop_host => 'www.exvo.local',
          :themes_host => 'themes.exvo.local',
          :blog_host => 'blog.exvo.local',
          :contacts_host => 'contacts.exvo.local',
          :inbox_host => 'inbox.exvo.local',
          :music_host => 'music.exvo.local',
          :pics_host => 'pics.exvo.local',
          :preview_host => 'preview.exvo.local'
        }
      }
    end

  end

end
