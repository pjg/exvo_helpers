module Exvo

  module Helpers

    # Dynamically define class methods
    class << self

      %w(auth budget cdn cfs desktop themes blog contacts inbox music pics preview store).each do |service|

        # def self.cdn_uri
        #   protocol = 'http://'
        #   protocol = 'https://' if (service == "auth" && auth_require_ssl) || (service == "budget" && budget_require_ssl)
        #   protocol = 'https://' if ["cdn", "cfs", "themes"].include?(service) && env.to_sym == :production
        #   suffix = '/blog' if service == "blog"
        #   protocol + cdn_host + suffix.to_s
        # end
        define_method "#{service}_uri" do
          protocol = 'http://'

          # explicit https for auth & budget
          protocol = 'https://' if (service == "auth" && send(:auth_require_ssl)) || (service == "budget" && send(:budget_require_ssl))

          # explicit https for cdn, cfs & themes in production
          protocol = 'https://' if ["cdn", "cfs", "themes"].include?(service) && env.to_sym == :production

          # blog now lives at http://www.exvo.com/blog, so adding '/blog' suffix is required
          suffix = '/blog' if service == "blog"

          protocol + send("#{service}_host") + suffix.to_s
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
        #   value = true if ENV["AUTH_DEBUG"] =~ /true/i
        #   value = false if ENV["AUTH_DEBUG"] =~ /false/i
        #   value = default_opts[env.to_sym]["auth_debug".to_sym] if value.nil?
        #   @@auth_debug = value
        # end
        define_method "auth_#{option}" do
          if class_variable_defined?("@@auth_#{option}") and !class_variable_get("@@auth_#{option}").nil?
            class_variable_get("@@auth_#{option}")
          else
            value = true if ENV["AUTH_#{option.upcase}"] =~ /true/i
            value = false if ENV["AUTH_#{option.upcase}"] =~ /false/i
            value = default_opts[env.to_sym]["auth_#{option}".to_sym] if value.nil?
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

      %w(client_id client_secret).each do |option|

        # def self.auth_client_id
        #   @@auth_client_id ||= ENV['AUTH_CLIENT_ID']
        # end
        define_method "auth_#{option}" do
          if class_variable_defined?("@@auth_#{option}") and !class_variable_get("@@auth_#{option}").nil?
            class_variable_get("@@auth_#{option}")
          else
            value = ENV["AUTH_#{option.upcase}"]
            class_variable_set("@@auth_#{option}", value)
          end
        end

        # def self.auth_client_id=(auth_client_id)
        #   @@auth_client_id = auth_client_id
        # end
        define_method "auth_#{option}=" do |value|
          class_variable_set("@@auth_#{option}", value)
        end

      end

    end


    # SSO Cookie Domain

    # Dynamically define class methods
    class << self

      %w(sso_cookie_domain).each do |option|

        # def self.sso_cookie_domain
        #   @@sso_cookie_domain ||= ENV['SSO_COOKIE_DOMAIN'] || default_opts[env.to_sym][:sso_cookie_domain]
        # end
        define_method "#{option}" do
          if class_variable_defined?("@@#{option}") and class_variable_get("@@#{option}")
            class_variable_get("@@#{option}")
          else
            domain = ENV["#{option.upcase}"] || default_opts[env.to_sym]["#{option}".to_sym]
            class_variable_set("@@#{option}", domain)
          end
        end

        # def self.sso_cookie_domain=(domain)
        #   @@sso_cookie_domain = domain
        # end
        define_method "#{option}=" do |value|
          class_variable_set("@@#{option}", value)
        end

      end

      %w(sso_cookie_secret).each do |option|

        # def self.sso_cookie_secret
        #   @@sso_cookie_secret ||= ENV['SSO_COOKIE_secret']
        # end
        define_method "#{option}" do
          if class_variable_defined?("@@#{option}") and class_variable_get("@@#{option}")
            class_variable_get("@@#{option}")
          else
            secret = ENV["#{option.upcase}"]
            class_variable_set("@@#{option}", secret)
          end
        end

        # def self.sso_cookie_secret=(secret)
        #   @@sso_cookie_secret = secret
        # end
        define_method "#{option}=" do |value|
          class_variable_set("@@#{option}", value)
        end

      end

    end


    # BUDGET

    # Dynamically define class methods
    class << self

      %w(require_ssl).each do |option|

        # def self.budget_require_ssl
        #   return @@budget_require_ssl if defined?(@@budget_require_ssl) && !@@budget_require_ssl.nil?
        #   value = true if ENV["BUDGET_REQUIRE_SSL"] =~ /true/i
        #   value = false if ENV["BUDGET_REQUIRE_SSL"] =~ /false/i
        #   value = default_opts[env.to_sym]["budget_require_ssl".to_sym] if value.nil?
        #   @@budget_require_ssl = value
        # end
        define_method "budget_#{option}" do
          if class_variable_defined?("@@budget_#{option}") and !class_variable_get("@@budget_#{option}").nil?
            class_variable_get("@@budget_#{option}")
          else
            value = true if ENV["BUDGET_#{option.upcase}"] =~ /true/i
            value = false if ENV["BUDGET_#{option.upcase}"] =~ /false/i
            value = default_opts[env.to_sym]["budget_#{option}".to_sym] if value.nil?
            class_variable_set("@@budget_#{option}", value)
          end
        end

        # def self.budget_require_ssl=(debug)
        #   @@budget_require_ssl = debug
        # end
        define_method "budget_#{option}=" do |value|
          class_variable_set("@@budget_#{option}", value)
        end

      end

    end


    # ENV

    # by default fall back to production; this way the omniauth-exvo's gem specs can pass
    # (they depend on this gem and on env, but nor Rails nor Merb is defined there)
    def self.env
      @@env ||= Rails.env if defined?(Rails)
      @@env ||= Merb.env if defined?(Merb)
      @@env ||= ENV["RACK_ENV"] if ENV["RACK_ENV"]
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
          :sso_cookie_domain => 'exvo.com',
          :budget_host => 'budget.exvo.com',
          :budget_require_ssl => true,
          :cdn_host => 'd33gjlr95u9pgf.cloudfront.net', # cloudfront.net so we can use https (cdn.exvo.com via https does not work properly)
          :cfs_host => 'cfs.exvo.com',
          :desktop_host => 'home.exvo.com',
          :themes_host => 'themes.exvo.com',
          :blog_host => 'www.exvo.com',
          :contacts_host => 'contacts.exvo.com',
          :inbox_host => 'inbox.exvo.com',
          :music_host => 'music.exvo.com',
          :pics_host => 'pics.exvo.com',
          :preview_host => 'preview.exvo.com',
          :store_host => 'store.exvo.com'
        },
        :staging => {
          :auth_debug => false,
          :auth_host => 'auth.exvo.co',
          :auth_require_ssl => false,
          :sso_cookie_domain => 'exvo.co',
          :budget_host => 'budget.exvo.co',
          :budget_require_ssl => false,
          :cdn_host => 'd1by559a994699.cloudfront.net',
          :cfs_host => 'cfs.exvo.co',
          :desktop_host => 'home.exvo.co',
          :themes_host => 'themes.exvo.co',
          :blog_host => 'www.exvo.co',
          :contacts_host => 'contacts.exvo.co',
          :inbox_host => 'inbox.exvo.co',
          :music_host => 'music.exvo.co',
          :pics_host => 'pics.exvo.co',
          :preview_host => 'preview.exvo.co',
          :store_host => 'store.exvo.co'
        },
        :development => {
          :auth_debug => false,
          :auth_host => 'auth.exvo.local',
          :auth_require_ssl => false,
          :sso_cookie_domain => 'exvo.local',
          :budget_host => 'budget.exvo.local',
          :budget_require_ssl => false,
          :cdn_host => 'home.exvo.local',
          :cfs_host => 'cfs.exvo.local',
          :desktop_host => 'home.exvo.local',
          :themes_host => 'themes.exvo.local',
          :blog_host => 'www.exvo.local',
          :contacts_host => 'contacts.exvo.local',
          :inbox_host => 'inbox.exvo.local',
          :music_host => 'music.exvo.local',
          :pics_host => 'pics.exvo.local',
          :preview_host => 'preview.exvo.local',
          :store_host => 'store.exvo.local'
        },
        :test => {
          :auth_debug => false,
          :auth_host => 'auth.exvo.local',
          :auth_require_ssl => false,
          :sso_cookie_domain => 'exvo.local',
          :budget_host => 'budget.exvo.local',
          :budget_require_ssl => false,
          :cdn_host => 'home.exvo.local',
          :cfs_host => 'cfs.exvo.local',
          :desktop_host => 'home.exvo.local',
          :themes_host => 'themes.exvo.local',
          :blog_host => 'www.exvo.local',
          :contacts_host => 'contacts.exvo.local',
          :inbox_host => 'inbox.exvo.local',
          :music_host => 'music.exvo.local',
          :pics_host => 'pics.exvo.local',
          :preview_host => 'preview.exvo.local',
          :store_host => 'store.exvo.local'
        }
      }
    end

  end

end
