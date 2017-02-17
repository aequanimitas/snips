defmodule DateSortTest do
  use ExUnit.Case

  test "Sorting dates" do
    dates = [~D[2017-01-31], ~D[2017-01-30], ~D[2017-01-29]]
    assert Enum.sort_by(dates, &DateTime.to_unix/1) ==
           [~D[2017-01-31], ~D[2017-01-30], ~D[2017-01-29]]
  end
end
