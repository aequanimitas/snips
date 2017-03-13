defmodule Lye.DCA.Evserv.Event do
  # timeout is {{Year, Month, Day}, {Hours, Minutes, Seconds}}
  defstruct name: "", description: "", pid: nil, timeout: {{1970,0,0}, {0,0,0}}
end
