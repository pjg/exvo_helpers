module Exvo

  module ViewHelpers

    # special link starting with '//' in production so that the webserver can choose between HTTP and HTTPS
    def javascript_bundle_include_tag(bundle)
      case Exvo::Helpers.env.to_sym
      when :production
        javascript_include_tag "//#{ Exvo::Helpers.cdn_host }/javascripts/#{bundle}.js"
      when :staging
        javascript_include_tag "http://#{ Exvo::Helpers.cdn_host }/javascripts/#{bundle}.js"
      else
        javascript_include_tag "http://#{ Exvo::Helpers.cdn_host }/javascripts/bundles/#{bundle}.js"
      end
    end

  end

end
