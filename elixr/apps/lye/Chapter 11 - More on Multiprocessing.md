## Server Process
- informal name for a process that runs for a long time. Code reference here is
  ```kitchen.ex```
- ```start```, ```loop``` are **interface functions**, functions that hide  the **implentation functions**. **Implementation functions** are the functions that run the server processes (```receive, send, spawn, etc.```)
- **Mental model**
  - a ```Module``` is a collection on functions
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
  - why async operations, because you don't care when they are executed,
    when requesting the server's state, that's the point where it becomes
    "blocking".
