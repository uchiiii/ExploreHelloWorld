### Content
- investigating the system call used in ping command by strace.

### Done
- `sudo strace -o ping.trace.txt ping -c 3 127.0.0.1` -> [output](ping.trace.txt)