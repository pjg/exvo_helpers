require 'spec_helper'

class SpecViewHelper
  include Exvo::ViewHelpers
end

describe Exvo::ViewHelpers do

  describe "javascript_bundle_include_tag" do

    let(:view_helper) { SpecViewHelper.new }

    before do
      Exvo::Helpers.stub(:env).and_return('production')
    end

    it "returns a javascript_include_tag based on env" do
      view_helper.should_receive(:javascript_include_tag).with("http://cdn.exvo.com/javascripts/plugins.js")
      view_helper.javascript_bundle_include_tag("plugins")
    end

    it "returns a stylesheet_link_tag based on env" do
      view_helper.should_receive(:stylesheet_link_tag).with("http://themes.exvo.com/stylesheets/themes/frost/all.css", { :media => 'all' })
      view_helper.themes_stylesheet_link_tag("frost/all", :media => 'all')
    end

    it "returns an image_tag based on env" do
      view_helper.should_receive(:image_tag).with("http://themes.exvo.com/stylesheets/images/icons/exvo.png", { :alt => 'Exvo' })
      view_helper.themes_image_tag("icons/exvo.png", :alt => 'Exvo')
    end

  end

end
