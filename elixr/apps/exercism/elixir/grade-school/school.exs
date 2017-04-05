defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t, integer) :: map
  def add(db, name, grade) do
    db = if Enum.empty?(grade(db, grade)) do
      Map.put(db, grade, [])
    else
      db
    end
    Map.put(db, grade, [name | Map.get(db, grade)])
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t]
  def grade(db, grade) do
    case Map.has_key?(db, grade) do
      true -> Map.get(db, grade)
      false -> []
    end
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t]}]
  def sort(db) do
    db = 
      db
      |> Enum.sort()
      |> Enum.map(fn {k, v} -> {k, Enum.sort(v)} end)
  end
end
