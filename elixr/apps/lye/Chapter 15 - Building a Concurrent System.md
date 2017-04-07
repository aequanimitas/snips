### Mapping out components

- ```IssueTracker.Cache``` is a process that monitors servers that are created
  with ```IssueTracker.Server```
- ```IssueTracker.Cache``` and ```IssueTracker.Server``` are backed up by
  ```GenServer``` behaviour

**Gotchas**
- ```GenServer.start/2``` returns a tuple, hence the earlier errors when passing
  the variable to the interface function

### Analyzing process dependencies
- single cache process

  might not be a big problem in practice. The case here is what if
  request handling takes 100 milliseconds, which means you can only
  process 10 requests per second and can't handle higher loads.

- dedicated process for critical code to prevent multiple executions

- processes that waiting for a message are suspended

- a list can't be modified by two simultaneous clients at the same
  time. Cache is a single process, processes are sequential

```cast``` is an async request, so you don't have any indication that the receiver actually received the message or even succeed.
