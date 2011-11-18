require "rails"

module Exvo
  class Railtie < Rails::Railtie
    initializer "exvo_helpers.add_to_rails_view_helpers" do |app|
      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, Exvo::ViewHelpers
      end
    end
  end
end
