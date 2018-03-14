require 'test_helper'

describe Slop::Option do
  def option(*args)
    Slop::Option.new(*args)
  end

  describe "#flag" do
    it "returns the flags joined by a comma" do
      assert_equal "-f, --bar", option(%w(-f --bar), nil, nil).flag
      assert_equal "--bar", option(%w(--bar), nil, nil).flag
    end
  end

  describe "#key" do
    it "uses the last flag and strips trailing hyphens" do
      assert_equal :foo, option(%w(-f --foo), nil, nil).key
    end

    it "converts dashes to underscores to make multi-word options symbol-friendly" do
      assert_equal :foo_bar, option(%w(-f --foo-bar), nil, nil).key
    end

    it "when specified, it won't convert dashes to underscores to make multi-word options symbol-friendly" do
      assert_equal :'foo-bar', option(%w(-f --foo-bar), nil, nil, underscore_flags: false).key
    end

    it "can be overridden" do
      assert_equal :bar, option(%w(-f --foo), nil, nil, key: "bar").key
    end
  end
end
