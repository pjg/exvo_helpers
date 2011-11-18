module Exvo
  module ViewHelpers
    def javascript_bundle_include_tag(bundle)
      case ::Rails.env
      when "development"
        javascript_include_tag "http://www.exvo.local/javascripts/bundles/#{bundle}.js"
      when "staging"
        javascript_include_tag "http://staging.cdn.exvo.com/javascripts/#{bundle}.js"
      else  
        javascript_include_tag "http://cdn.exvo.com/javascripts/#{bundle}.js"
      end
    end
  end
end