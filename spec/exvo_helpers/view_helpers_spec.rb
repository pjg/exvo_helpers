require 'spec_helper'

describe Exvo::ViewHelpers do

  describe "bundles" do
    it "should return javascript based on env" do
      Kernel.const_set(:Rails, Module)
      Rails.should_receive(:env).and_return('production')
      Exvo::ViewHelpers.module_eval do
        module_function(:javascript_bundle_include_tag)
      end
      Exvo::ViewHelpers.javascript_bundle_include_tag("plugins").should eql("cfs_host") 
    end
  end
end