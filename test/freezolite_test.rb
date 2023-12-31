require "test_helper"

class FreezeTheListTest < Minitest::Test
  if ENV["FREEZOLITE_DISABLED"] == "true"
    def test_fixtures_default_behaviour
      load File.join(__dir__, "./fixtures/app/name.rb")

      result = Name.new + "test"

      assert result.end_with?("test")

      load File.join(__dir__, "./fixtures/lib/strings.rb")

      refute Strings.hello.frozen?

      load File.join(__dir__, "./fixtures/test/name_test.rb")

      assert_equal "name 1 2", NameTest.run
    end
  else
    def test_fixtures_with_freezolite_enabled
      load File.join(__dir__, "./fixtures/app/name.rb")

      assert_raises(FrozenError) { Name.new + "test" }

      load File.join(__dir__, "./fixtures/app/name_unfrozen.rb")

      result = Name.new + "test"
      assert result.end_with?("test")

      load File.join(__dir__, "./fixtures/lib/strings.rb")
      # This folder is not activated by Freezolite
      refute Strings.hello.frozen?

      load File.join(__dir__, "./fixtures/test/name_test.rb")

      assert_raises(FrozenError) { NameTest.run }
    end

    def test_excluded_patterns
      load File.join(__dir__, "./fixtures/app/vendor/bundle/gem.rb")

      assert_equal "hot", VendorGem::CONSTANT
      refute VendorGem::CONSTANT.frozen?
    end
  end
end
