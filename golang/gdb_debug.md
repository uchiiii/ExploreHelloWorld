
### How
1. compile a file with `-gcflags=all="-N -l"` as 
```
go build -gcflags=all="-N -l" -o thread thread.go
```
2. `gdb ./thread`
3. `b thread.go:27`
4. `run`
5. `info threads`

### Reference
- https://golang.org/doc/gdb