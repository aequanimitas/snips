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

```cast``` is an async request, so you don't have any indication that the
receiver actually received the message or even succeed.

### Analyzing the system

Single database process, performs encoding and decoding of binary data,
disk I/O operations. Performance depends largely on size of inputs, load and
list sizes. Check ```million_requests/0``` in ```Database``` module to see how
long it would block

### Addressing bottleneck

**When to run code in a dedicated process?**
- code that manages long-living state
- code that handles resource reusing: TCP connections, db connections, piping to
  OS process
- critical section of code must be synchronized, only a single process can run
  the said process in any moment

```Database``` stores each item into its own corresponding file, multiple
concurrent read/writes is not a good idea in this setup.

#### Handling request concurrently
- a central server process spawns a worker process that does the actual request
- worker process does an async request
- for sync requests, central server spawns another process, inside this new
  process the genserver will reply, but the ```handle_call``` immediately returns
  a ```{:noreply, db_folder}``` which signals that the central server can't reply
  at the moment
