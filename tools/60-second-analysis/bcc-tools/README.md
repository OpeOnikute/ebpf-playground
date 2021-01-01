## List
Running list. Will be updated as I get to the individual chapter for each too.
I'm not adding sample results to this until I figure out how to simulate usage. Thinking about how to do so with Nginx but these layers haven't been touched so far.

- `execsnoop` - Shows new process execution by printing one line of output for every execve(2) call.

- `opensnoop` - Prints one line of output for every open(2) call.

- `ext4slower` - Traces common ops from the ext4 filesytem and prints out the ones that exceed a latency threshold.

- `biolatency` - Traces Disk I/O latency and prints out as a histogram.

- `biosnoop` - Prints one line of output for each Disk I/O, along with its latency. Allows to examine Disk I/O more closely.

- `cachestat` - Shows filesystem cache hit and miss rates.

- `tcpconnect` - Shows active TCP connections.

- `tcpaccept` - Shows TCP accepts.

- `tcpretrans` - Shows the number of TCP retransmits.

- `runqlat` - Traces run queue latency.

- `profile` - Profiles CPU or smth. Will find out more in subsequent chapters.