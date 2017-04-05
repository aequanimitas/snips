## Server Process
- informal name for a process that runs for a long time. Code reference here is
  ```kitchen.ex```
- ```start```, ```loop``` are **interface functions**, functions that hide  the **implentation functions**. **Implementation functions** are the functions that run the server processes (```receive, send, spawn, etc.```)
- **Mental model**
  - a ```Module``` is a collection on functions, makes a more clear distinction and reason on why functions inside the same module can run on different processes.
  - functions in the same module will be running on different processes
  - no special relation between a module and a function
  - processes are sequential by nature, so if you send a thousand
    messages to a single process, they'll be processed one by one.
    Check out ```Gratitude``` module to review how to do sequential
    and concurrent processing
  - a function can still do a ```receive``` even if it assigned to a
    label inside the function
    ```
    label = receive do
      {pid, message} -> send pid, {:ok, "You can also do this"}
    end
    ```
  - Why async operations? Because you don't care when they are executed.
    When requesting the server's state, that's the point where it becomes
    "blocking".

### Complex States
- Extract state manipulation into a module, letting the server process
  focus on message passing

### Selective receive
- received messages that doesn't match any pattern are pushed to the save stack/queue
- if the next message matches, the save queue is then put back to the message stack
- since processes are sequential in nature, if the queue of unmatched messages
  becomes huge, it might take some time to
- checklist:
  - check the pattern
  - check if the state was actually passed to where its intended
  - single processes when it should be many
- another strategy for unmatched messages is a catch-all, where
  you could also plugin a logging mechanism

### Shared nothing Concurrency
- passing large messages between processes may cause issues
- messages that are less than 64 bytes are maintained in the binary heap
- processes doesn't share memory so there's no need for ```locks``` and ```mutexes```
- a process can't corrupt the memory of the other
