require "rails"
require "exvo_helpers"

module Exvo
  class Railtie < Rails::Railtie
    initializer "exvo_helpers.extend_rails_helpers" do |app|
      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, Exvo::ViewHelpers
      end
    end
  end
end