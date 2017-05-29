defmodule FooSpec do
  use ExUnit.Spec, async: true

  describe ".foo/1" do
    context "when bacon" do
      it "returns \"bacon!\"" do
        assert 1 + 1 == 3
      end
    end
  end
end
