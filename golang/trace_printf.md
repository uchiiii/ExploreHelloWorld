
### Content
```
gdb ./hello
catch syscall write
run
backtrace
```
output
```
#0  syscall.Syscall () at /usr/local/go/src/syscall/asm_linux_386.s:27
#1  0x080c19c9 in syscall.write (fd=1, p=..., n=<optimized out>, err=...) at /usr/local/go/src/syscall/zsyscall_linux_386.go:914
#2  0x080c3295 in syscall.Write (fd=1, p=..., n=<optimized out>, 
    err=<error reading variable: access outside bounds of object referenced via synthetic pointer>)
    at /usr/local/go/src/syscall/syscall_unix.go:212
#3  internal/poll.ignoringEINTRIO (fd=1, p=..., fn=<optimized out>) at /usr/local/go/src/internal/poll/fd_unix.go:581
#4  internal/poll.(*FD).Write (fd=0x8904040, p=..., ~r1=<optimized out>, ~r2=...) at /usr/local/go/sあrc/internal/poll/fd_unix.go:274
#5  0x080c3758 in os.(*File).write (f=0x8902008, n=<optimized out>, err=..., b=...) at /usr/local/go/src/os/file.go:174
#6  os.(*File).Write (f=0x8902008, b=..., n=<optimized out>, err=...) at /usr/local/go/src/os/file.go:174
#7  0x080c6d7a in fmt.Fprintf (w=<error reading variable: access outside bounds of object referenced via synthetic pointer>, format=..., a=..., 
```

これより, ` /usr/local/go/src/syscall/zsyscall_linux_386.go`から`/usr/local/go/src/syscall/asm_linux_386.s`にあるアセンブリコードを呼び出しているのがわかる.
実際にコードを見るとsyscall(`INT	$0x80`)が呼ばれていることがわかる.
```
// See ../runtime/sys_linux_386.s for the reason why we always use int 0x80
// instead of the glibc-specific "CALL 0x10(GS)".
#define INVOKE_SYSCALL	INT	$0x80

// func Syscall(trap uintptr, a1, a2, a3 uintptr) (r1, r2, err uintptr);
// Trap # in AX, args in BX CX DX SI DI, return in AX
TEXT ·Syscall(SB),NOSPLIT,$0-28
	CALL	runtime·entersyscall(SB)
	MOVL	trap+0(FP), AX	// syscall entry
	MOVL	a1+4(FP), BX
	MOVL	a2+8(FP), CX
	MOVL	a3+12(FP), DX
	MOVL	$0, SI
	MOVL	$0, DI
	INVOKE_SYSCALL
	CMPL	AX, $0xfffff001
	JLS	ok
	MOVL	$-1, r1+16(FP)
	MOVL	$0, r2+20(FP)
	NEGL	AX
	MOVL	AX, err+24(FP)
	CALL	runtime·exitsyscall(SB)
	RET
ok:
	MOVL	AX, r1+16(FP)
	MOVL	DX, r2+20(FP)
	MOVL	$0, err+24(FP)
	CALL	runtime·exitsyscall(SB)
	RET
```