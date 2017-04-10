```
alias Lye.IssueTracker.{Database, Cache, Server}
{:ok, cache_pid} = Cache.start
sentire = Cache.server_process(cache, "sentire")
vue = Cache.server_process(cache, "vue")
Server.add(sentire, "issue 1")
Server.add(sentire, "issue 2")
Server.all(sentire)
["issue 2", "issue 1"]
```
