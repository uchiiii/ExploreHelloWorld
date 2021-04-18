# To Understand "Hello World"

### environment
- Linux kernel (Ubuntu)
- x86 (32 bits)
- Dockerfile

### System Call
- https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md#x86-32_bit

### assembly
- `gcc hello.c -o hello -Wall -g -O0 -static`

```assembly
 080488a5 <main>:
 80488a5:	8d 4c 24 04          	lea    0x4(%esp),%ecx        
 80488a9:	83 e4 f0             	and    $0xfffffff0,%esp  // stack pointerを16byteの境界に合わせている. 高速化.
 80488ac:	ff 71 fc             	pushl  -0x4(%ecx)        // 戻れるように値を格納. 
 80488af:	55                   	push   %ebp              // base pointerを格納.
 80488b0:	89 e5                	mov    %esp,%ebp         // base pointerを更新.
 80488b2:	53                   	push   %ebx              
 80488b3:	51                   	push   %ecx
 80488b4:	e8 32 00 00 00       	call   80488eb <__x86.get_pc_thunk.ax>
 80488b9:	05 47 07 09 00       	add    $0x90747,%eax
 80488be:	89 ca                	mov    %ecx,%edx
 80488c0:	8b 4a 04             	mov    0x4(%edx),%ecx
 80488c3:	8b 09                	mov    (%ecx),%ecx
 80488c5:	83 ec 04             	sub    $0x4,%esp
 80488c8:	51                   	push   %ecx
 80488c9:	ff 32                	pushl  (%edx)
 80488cb:	8d 90 68 2c fd ff    	lea    -0x2d398(%eax),%edx
 80488d1:	52                   	push   %edx
 80488d2:	89 c3                	mov    %eax,%ebx
 80488d4:	e8 a7 70 00 00       	call   804f980 <_IO_printf>
 80488d9:	83 c4 10             	add    $0x10,%esp
 80488dc:	b8 00 00 00 00       	mov    $0x0,%eax          // return 0
 80488e1:	8d 65 f8             	lea    -0x8(%ebp),%esp
 80488e4:	59                   	pop    %ecx
 80488e5:	5b                   	pop    %ebx               // pushlした分の半分
 80488e6:	5d                   	pop    %ebp               // pushlした分の半分(エンディアンに関係?)
 80488e7:	8d 61 fc             	lea    -0x4(%ecx),%esp
 80488ea:	c3                   	ret    

080488eb <__x86.get_pc_thunk.ax>:
 80488eb:	8b 04 24             	mov    (%esp),%eax
 80488ee:	c3                   	ret    
 80488ef:   90                      nop

```

- in `vfprintf`
```
 0x807ff06 <vfprintf+2470>       call   *0x1c(%ecx)
 0x807fb20 <vfprintf+1472>       call   0x805e3e0 <strchrnul>
 0x807fb5e <vfprintf+1534>       call   *0x1c(%ecx)         // ここで出力
 0x808140c <vfprintf+7852>       call   0x806a620 <strlen> 
 0x8080a23 <vfprintf+5315>       call   *0x1c(%eax) 
```

- in `_IO_new_file_xsputn`
```
 0x8053d36 <_IO_new_file_xsputn+102>     call   *0xc(%ebp) 
```

- in `_IO_new_file_overflow`
```
 0x80549d5 <_IO_new_file_overflow+229>   call   0x8054130 <_IO_new_do_write>        
```

- in `_IO_new_do_write`
```

```

- in `new_do_write`
```
0x8052404 <new_do_write+100>    call   *0x3c(%ebp) 
```


#### Result
```
#0  0xf7fdec19 in __kernel_vsyscall ()
#1  0x0806bdd0 in write ()
#2  0x0805362b in _IO_new_file_write ()
#3  0x08052407 in new_do_write ()
#4  0x0805414d in _IO_new_do_write ()
#5  0x080549da in _IO_new_file_overflow ()
#6  0x08053d39 in _IO_new_file_xsputn ()
```

