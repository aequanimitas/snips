### Intro to OTP
- You'll do the init a process, loop, receive, send and maintain state when dealing
  with server processes / stateful server processes. A concrete implementation
  of such flow should be made.
- A lot of things are still haven't mentioned here such as trapping exits,
  making sure you that the reply you send actually came your intended receiver.

**Generic code drives the process, specific implementation must provide the
missing pieces**

### Generalizations
- the initial state is received from the client by passing a module with a
  function named ```init```
```
defmodule Lye.ServerProcess do
  def start(callback_module) do
    spawn(fn ->
      initial_state = callback_module.init
      loop(callback_module, initial_state)
    end)
  end
end
```

- ```loop```: generic code that handles receiving and sending messages. Sends a
  response back to the caller. The server blindly sends the the request to the
  client process via ```handle_call```
```
defmodule Lye.ServerProcess do
  ...
  def loop(callback_module, current_state) do
    receive do
      {request, caller} ->
        {response, new_state} = callback_module.handle_call(
          request,
          current_state
        )
        send caller, {:response, response}
        loop(callback_module, new_state)
    end
  end
  ...
end
```

- ```call``` - commands a request to the server process
```
defmodule Lye.ServerProcesses do
  ...
  def call(server_pid, request) do
    send server_pid, {request, self()}
    receive do
      {:response, response} -> response
    end
  end
  ...
end
```

### Generic Abstraction

### Async requests
- current implementation is blocking because you are waiting for a reply from the
  server process
- async requests are *fire and forget* requests
- ```call``` for synchronous, ```cast``` for async


### OTP Behaviours

**Behaviours**
- generic code, common patterns
- to use in your code, you must implement the corresponding callback module
- satisfy the contract defined by the ```behaviour```, implement and export a
  set of functions

**OTP Pre-defined behaviours**

- gen_server - generic stateful server process
- supervisor - error handling and recovery
- application - generic implementations of components and libraries
- gen_fsm - run finite-state machin in stateful server process
- gen_event - event-handling support

### Handling requests
- implement 3 callbacks, ```init/1, handle_cast/2, handle_call/2```


- ``` GenServer.start/2 ``` is a synchronous request, so it depends when the ```init``` callback finishes its computation
- use ``` GenServer.call/3``` when you want timeouts, default is
  5 seconds. Last argument is timeout

```handle_info``` needs a match-all definition
```handle_cast``` and ```handle_call``` are well-defined requests

### OTP Compliant Processes
- usually avoid using plain processes started with ```spawn```
- strive that your code adheres as a OTP-Compliant process
