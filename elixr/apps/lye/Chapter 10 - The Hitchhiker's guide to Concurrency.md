## Concurrency and Parallelism

Both means processes running independently, the difference is in concurrency, 
they don’t all run necessarily at the same time, while parallelism means running 
all at the same time

## Scalability
- Users/Processes only react when a specific event happens 
- Processes only doing small computations, switching between them as events came 
  through
- For efficiency reasons, processes needs to be started and stopped very quickly
  (receiving call, hanging up)
- No process pools, programs use as much process as they need
- Sharing memory is forbidden and unreliable, inconsistent state. Processes 
  should communicate by sending messages where all the data is copied. Slower 
  but safer

#### NOTE
Bypassing hardware limitations:
- make the hardware better
- add more hardware

## Fault Tolerance
There is no 100%. Let it crash, find good ways to handle it rather than trying 
to prevent them all. Systems can either have clean shutdowns and crashes 
(termination with unexpected error). 

Faulty components should be automatically terminated when errors that corrupt
data arise

### Clean shutdown *(read more on the strategies below)*
- single assignment 
- shared-nothing 
- avoiding locks - locks leaves other processes from accessing data or leaving
  it in an inconsistent state

Erlang's solution is to make processes killed quickly to avoid data corruption
and transient *(means lasting only a short time)* bugs. See 3rd bullet point in
scalability. 

Async message passing
- no sense in checking if other process received the message, you just send it
  with having no guarantees in mind if the receiving proc is still alive

## Concurrency Implementation
- Schedulers
  - one thread per core
  - has a run queue, list of erlang processes
  - if a queue has too much processes, it is then migrated to another queue
  - Erlang VM takes care of load balancing
- ring benchmark, remember erlang exercises on concurrency, even there's only
  one process that does something useful, the VM still spends time distributing
  the load across schedulers / cores.

**A process is a function that runs a function and once it's finished, it disappears**

SMP - Symmetrical Multi Processor

- Process mailbox messages are kept in the order they are received

```receive``` and ```case``` looks the same, the only the difference is that in
```case```, the variable binds in the expression after ```case``` while in
```receive``` the variable binds in the messages received

on the ```Dolphin``` example, after the spawned process receives the message, it
is immediately killed. 

on ```dolphin3/0```, recursion is used to bypass creating new processes
