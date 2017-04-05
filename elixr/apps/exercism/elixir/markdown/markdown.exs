defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"

    ## Notes
    - Use pipes
  """
  @spec parse(String.t) :: String.t
  def parse(m) do
    seperate_by_next_line(m)
    |> Enum.map(fn t -> process(t) end)
    |> rebuild
  end

  defp seperate_by_next_line(p), do: String.split(p, "\n")

  defp rebuild(lst), do: Enum.join(lst)

  defp process(t) do
    # TEST THESE ONES
    if is_header(t) do
      #if String.starts_with?(t, "#") do
        parse_header_md_level(t)
        |> enclose_with_header_tag()
        #enclose_with_header_tag(parse_header_md_level(t))
        #else
        #  parse_list_md_level(t)
        #end
    else
      enclose_with_paragraph_tag(String.split(t))
    end
  end

  @spec is_header(str :: String.t()) :: boolean()
  def is_header(str), do: is_header_pound(str) or is_header_star(str)

  # MACRO! YAY!
  def is_header_pound(str), do: String.starts_with?(str, "#")
  def is_header_star(str), do: String.starts_with?(str, "*")

  def parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)
    {to_string(String.length(h)), Enum.join(t, " ")}
  end

  # Pipe, be consistent across code
  # Interpolate, be consistent across code
  def parse_list_md_level(l) do
    t = String.trim_leading(l, "* ")
        |> String.split
    "<li>#{join_words_with_tags(t)}</li>"
  end

  defp enclose_with({tag, content}) do
    #"<h#{hl}>#{htl}</h#{hl}>"
    #"<#{tag}#{level}>#{content}</#{level}#{tag}>"
  end

  # Interpolate, be consistent across code
  def enclose_with_header_tag({hl, htl}) do
    "<h#{hl}>#{htl}</h#{hl}>"
  end

  defp enclose_with_paragraph_tag(t) do
    "<p>#{join_words_with_tags(t)}</p>"
  end

  defp join_words_with_tags(t) do
    Enum.join(Enum.map(t, fn(w) -> replace_md_with_tag(w) end), " ")
  end

  defp replace_md_with_tag(w) do
    replace_suffix_md(replace_prefix_md(w))
  end

  defp replace_prefix_md(w) do
    cond do
      w =~ ~r/^#{"__"}{1}/ -> String.replace(w, ~r/^#{"__"}{1}/, "<strong>", global: false)
      w =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(w, ~r/_/, "<em>", global: false)
      true -> w
    end
  end

  defp replace_suffix_md(w) do
    cond do
      w =~ ~r/#{"__"}{1}$/ -> String.replace(w, ~r/#{"__"}{1}$/, "</strong>")
      w =~ ~r/[^#{"_"}{1}]/ -> String.replace(w, ~r/_/, "</em>")
      true -> w
    end
  end

  defp patch(l) do
    String.replace_suffix(String.replace(l, "<li>", "<ul>" <> "<li>", global: false), "</li>", "</li>" <> "</ul>")
  end
end
