require 'spec_helper'

class SpecViewHelper
  include Exvo::ViewHelpers
end

describe Exvo::ViewHelpers do

  let(:view_helper) { SpecViewHelper.new }

  describe "#javascript_bundle_include_tag" do
    it "returns a javascript_include_tag based on env" do
      view_helper.should_receive(:javascript_include_tag).with("https://d33gjlr95u9pgf.cloudfront.net/javascripts/plugins.js")
      view_helper.javascript_bundle_include_tag("plugins")
    end
  end

  describe "#themes_stylesheet_link_tag" do
    it "returns a stylesheet_link_tag based on env" do
      view_helper.should_receive(:stylesheet_link_tag).with("https://themes.exvo.com/stylesheets/themes/frost/all.css", { :media => 'all' })
      view_helper.themes_stylesheet_link_tag("frost/all", :media => 'all')
    end
  end

  describe "#themes_image_tag" do
    it "returns an image_tag based on env" do
      view_helper.should_receive(:image_tag).with("https://themes.exvo.com/stylesheets/images/icons/exvo.png", { :alt => 'Exvo' })
      view_helper.themes_image_tag("icons/exvo.png", :alt => 'Exvo')
    end
  end

  describe "#google_analytics" do
    let(:snippet) { view_helper.google_analytics("123", :domain => 'exvo.com', :track_hash_changes => true) }

    specify { snippet.should match(/<script type="text\/javascript">/) }
    specify { snippet.should match(/'_setAccount', '123'/) }
    specify { snippet.should match(/'_setDomainName', 'exvo.com'/) }
    specify { snippet.should match(/window.location.hash/) }
  end

  describe "#kissmetrics" do
    let(:snippet) { view_helper.kissmetrics }
    let(:email) { "me@me.com" }
    let(:current_user) { Struct.new(:email).new(email) }

    before do
      view_helper.should_receive(:current_user).at_least(1).times.and_return(current_user)
    end

    specify { snippet.should match(/<script type="text\/javascript">/) }
    specify { snippet.should match(/kissmetrics\.com/) }
    specify { snippet.should match(%r(identify.+#{email})) }
  end

end
