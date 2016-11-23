forked_path = System.get_env("HOME") <> "/Codes/forked"

File.cd forked_path

case File.ls do
  {:ok, file_list} -> 
    file_list 
    |> Enum.each(fn(x) -> File.cd(System.get_env("HOME") <> "/Codes/forked/" <> x); System.cmd("git", ["pull"], [])  end)
end
