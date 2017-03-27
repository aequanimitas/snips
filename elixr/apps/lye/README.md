# Lye

Codes and notes from Learn you some Erlang

### Chapter 10: Concurrency and Parallelism
Both means processes running independently, the difference is in concurrency, they
don’t run necessarily at the same time, while parallelism means running the
same time.

#### Scalability

Properties needed (keep in mind, these were the design decisions for OTP)
- users/processes only react when a specific event happens (receiving call, hanging up). 
- Processes only doing small computations, switching between them as events came through
- For efficiency reasons, processes needs to be started and stopped very quickly. To counter-act this property, you need to do a recursive call so that the function is alive again and waiting for
new messages
- No process pools, programs use as much process as they need
- Sharing memory is forbidden and unreliable, inconsistent state.
- Processes should communicate by sending messages where all the data is copied. Slower but safe


#### Fault Tolerance
There is no 100%. Let it crash, find good ways to handle it rather than trying to prevent them all. Systems can either have clean shutdowns and crashes (termination with unexpected error).
