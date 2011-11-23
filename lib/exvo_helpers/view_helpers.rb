module Exvo

  module ViewHelpers

    def javascript_bundle_include_tag(bundle)
      case Exvo::Helpers.env.to_sym
      when :production
        # FIXME change back to '//' in production so that the webserver can choose between HTTP and HTTPS
        # note, that it requires a proper SSL certificate installed for cdn.exvo.com domain
        javascript_include_tag "http://#{ Exvo::Helpers.cdn_host }/javascripts/#{bundle}.js"
      when :staging
        javascript_include_tag "http://#{ Exvo::Helpers.cdn_host }/javascripts/#{bundle}.js"
      else
        javascript_include_tag "http://#{ Exvo::Helpers.cdn_host }/javascripts/bundles/#{bundle}.js"
      end
    end

  end

end
