require 'spec_helper'

class SpecViewHelper
  include Exvo::ViewHelpers
end

describe Exvo::ViewHelpers do

  describe "javascript_bundle_include_tag" do

    let(:view_helper) { SpecViewHelper.new }

    it "should return the javascript_include_tag based on env" do
      Exvo::Helpers.stub(:env).and_return('production')
      view_helper.should_receive(:javascript_include_tag).with("http://cdn.exvo.com/javascripts/plugins.js")
      view_helper.javascript_bundle_include_tag("plugins")
    end
  end

end
