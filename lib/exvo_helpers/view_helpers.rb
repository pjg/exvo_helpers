module Exvo

  module ViewHelpers

    # Returns `javascript_include_tag` with link to js bundles (based on env)
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

    # Returns `stylesheet_link_tag` with link to css on themes (based on env)
    def themes_stylesheet_link_tag(path, options = {})
      path = '/' + path unless path.start_with?('/')
      path = path + '.css' unless path.end_with?('.css')
      stylesheet_link_tag(Exvo::Helpers.themes_uri + '/stylesheets/themes' + path, options)
    end

    # Returns `image_tag` with link to image on themes (based on env)
    def themes_image_tag(path, options = {})
      path = '/' + path unless path.start_with?('/')
      image_tag(Exvo::Helpers.themes_uri + '/stylesheets/images' + path, options)
    end

  end

end
