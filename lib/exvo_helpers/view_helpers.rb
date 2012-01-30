module Exvo

  module ViewHelpers

    # Returns `javascript_include_tag` with link to js bundles (based on env)
    def javascript_bundle_include_tag(bundle)
      case Exvo::Helpers.env.to_sym
      when :production
        javascript_include_tag "#{Exvo::Helpers.cdn_uri}/javascripts/#{bundle}.js"
      when :staging
        javascript_include_tag "#{Exvo::Helpers.cdn_uri}/javascripts/#{bundle}.js"
      else
        javascript_include_tag "#{Exvo::Helpers.cdn_uri}/javascripts/bundles/#{bundle}.js"
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

    def google_analytics(domain, account)
      script = <<END
<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', '#{account}']);
  _gaq.push(['_setDomainName', '#{domain}']);
  _gaq.push(['_setAllowLinker', true]);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

  var current_location_hash = window.location.hash;
  var update_hash = function() {
    if (current_location_hash != window.location.hash) {
      current_location_hash = window.location.hash;
      _gaq.push(['_trackPageview', current_location_hash]);
    }
  }
  setInterval(update_hash, 500);
</script>
END

      if Exvo::Helpers.env.to_sym == :production
        script.respond_to?(:html_safe) ? script.html_safe : script
      end
    end

  end

end
