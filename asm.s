	.file	"asm.c"
	.text
	.globl	alias_list
	.bss
	.align 8
	.type	alias_list, @object
	.size	alias_list, 8
alias_list:
	.zero	8
	.text
	.globl	free_aliases
	.type	free_aliases, @function
free_aliases:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	jmp	.L2
.L3:
	movq	alias_list(%rip), %rax
	movq	%rax, -8(%rbp)
	movq	alias_list(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, alias_list(%rip)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
.L2:
	movq	alias_list(%rip), %rax
	testq	%rax, %rax
	jne	.L3
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	free_aliases, .-free_aliases
	.section	.rodata
	.align 8
.LC0:
	.string	"Failed to allocate memory for alias"
	.text
	.globl	add_alias
	.type	add_alias, @function
add_alias:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$24, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L5
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	jmp	.L4
.L5:
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	strdup@PLT
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	strdup@PLT
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, 8(%rax)
	movq	alias_list(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, 16(%rax)
	movq	-8(%rbp), %rax
	movq	%rax, alias_list(%rip)
.L4:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	add_alias, .-add_alias
	.globl	get_alias
	.type	get_alias, @function
get_alias:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	alias_list(%rip), %rax
	movq	%rax, -8(%rbp)
	jmp	.L8
.L11:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L9
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	jmp	.L10
.L9:
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -8(%rbp)
.L8:
	cmpq	$0, -8(%rbp)
	jne	.L11
	movl	$0, %eax
.L10:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	get_alias, .-get_alias
	.section	.rodata
.LC1:
	.string	"exit"
.LC2:
	.string	"cd"
.LC3:
	.string	"cd: expected argument\n"
.LC4:
	.string	"pwd"
.LC5:
	.string	"echo"
.LC6:
	.string	"%s "
.LC7:
	.string	"clear"
.LC8:
	.string	"\033[H\033[J"
.LC9:
	.string	"alias"
.LC10:
	.string	"alias %s='%s'\n"
.LC11:
	.string	"alias: %s not found\n"
	.text
	.globl	execute_builtin
	.type	execute_builtin, @function
execute_builtin:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1088, %rsp
	movq	%rdi, -1080(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-1080(%rbp), %rax
	movq	(%rax), %rax
	leaq	.LC1(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L13
	movl	$0, %eax
	call	free_aliases
	movq	-1080(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	$-1, %eax
	jmp	.L14
.L13:
	movq	-1080(%rbp), %rax
	movq	(%rax), %rax
	leaq	.LC2(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L15
	movq	-1080(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L16
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$22, %edx
	movl	$1, %esi
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	jmp	.L17
.L16:
	movq	-1080(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	chdir@PLT
	testl	%eax, %eax
	je	.L17
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
.L17:
	movl	$1, %eax
	jmp	.L14
.L15:
	movq	-1080(%rbp), %rax
	movq	(%rax), %rax
	leaq	.LC4(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L18
	leaq	-1040(%rbp), %rax
	movl	$1024, %esi
	movq	%rax, %rdi
	call	getcwd@PLT
	testq	%rax, %rax
	je	.L19
	leaq	-1040(%rbp), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L20
.L19:
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
.L20:
	movl	$1, %eax
	jmp	.L14
.L18:
	movq	-1080(%rbp), %rax
	movq	(%rax), %rax
	leaq	.LC5(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L21
	movl	$1, -1068(%rbp)
	jmp	.L22
.L23:
	movl	-1068(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-1080(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	.LC6(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -1068(%rbp)
.L22:
	movl	-1068(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-1080(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L23
	movl	$10, %edi
	call	putchar@PLT
	movl	$1, %eax
	jmp	.L14
.L21:
	movq	-1080(%rbp), %rax
	movq	(%rax), %rax
	leaq	.LC7(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L24
	leaq	.LC8(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, %eax
	jmp	.L14
.L24:
	movq	-1080(%rbp), %rax
	movq	(%rax), %rax
	leaq	.LC9(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L25
	movq	alias_list(%rip), %rax
	movq	%rax, -1064(%rbp)
	movq	-1080(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L26
	jmp	.L27
.L28:
	movq	-1064(%rbp), %rax
	movq	8(%rax), %rdx
	movq	-1064(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	.LC10(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-1064(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -1064(%rbp)
.L27:
	cmpq	$0, -1064(%rbp)
	jne	.L28
	jmp	.L29
.L26:
	movq	-1080(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -1056(%rbp)
	movq	-1056(%rbp), %rax
	movq	%rax, %rdi
	call	get_alias
	movq	%rax, -1048(%rbp)
	cmpq	$0, -1048(%rbp)
	je	.L30
	movq	-1048(%rbp), %rdx
	movq	-1056(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC10(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L29
.L30:
	movq	-1056(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC11(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L29:
	movl	$1, %eax
	jmp	.L14
.L25:
	movl	$0, %eax
.L14:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L31
	call	__stack_chk_fail@PLT
.L31:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	execute_builtin, .-execute_builtin
	.section	.rodata
.LC12:
	.string	"fork"
.LC13:
	.string	"PATH"
.LC14:
	.string	":"
.LC15:
	.string	"%s/%s"
.LC16:
	.string	"%s: command not found\n"
	.text
	.globl	execute_external
	.type	execute_external, @function
execute_external:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1088, %rsp
	movq	%rdi, -1080(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	call	fork@PLT
	movl	%eax, -1060(%rbp)
	cmpl	$-1, -1060(%rbp)
	jne	.L33
	leaq	.LC12(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$0, %eax
	jmp	.L34
.L33:
	cmpl	$0, -1060(%rbp)
	jne	.L35
	leaq	.LC13(%rip), %rax
	movq	%rax, %rdi
	call	getenv@PLT
	movq	%rax, -1048(%rbp)
	movq	-1048(%rbp), %rax
	leaq	.LC14(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	%rax, -1056(%rbp)
	jmp	.L36
.L38:
	movq	-1080(%rbp), %rax
	movq	(%rax), %rcx
	movq	-1056(%rbp), %rdx
	leaq	-1040(%rbp), %rax
	movq	%rcx, %r8
	movq	%rdx, %rcx
	leaq	.LC15(%rip), %rdx
	movl	$1024, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	snprintf@PLT
	movq	-1080(%rbp), %rcx
	leaq	-1040(%rbp), %rax
	movl	$0, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	execve@PLT
	cmpl	$-1, %eax
	je	.L37
	movl	$0, %edi
	call	exit@PLT
.L37:
	leaq	.LC14(%rip), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	strtok@PLT
	movq	%rax, -1056(%rbp)
.L36:
	cmpq	$0, -1056(%rbp)
	jne	.L38
	movq	-1080(%rbp), %rax
	movq	(%rax), %rdx
	movq	stderr(%rip), %rax
	leaq	.LC16(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %edi
	call	exit@PLT
.L35:
	leaq	-1064(%rbp), %rcx
	movl	-1060(%rbp), %eax
	movl	$0, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	waitpid@PLT
	movl	$1, %eax
.L34:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L39
	call	__stack_chk_fail@PLT
.L39:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	execute_external, .-execute_external
	.section	.rodata
.LC17:
	.string	"Did you mean:"
.LC18:
	.string	"    %s\n"
	.text
	.globl	suggest_command
	.type	suggest_command, @function
suggest_command:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1072, %rsp
	movq	%rdi, -1064(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	.LC13(%rip), %rax
	movq	%rax, %rdi
	call	getenv@PLT
	movq	%rax, -1048(%rbp)
	movq	-1048(%rbp), %rax
	leaq	.LC14(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	%rax, -1056(%rbp)
	movq	-1064(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC16(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC17(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L41
.L43:
	movq	-1064(%rbp), %rcx
	movq	-1056(%rbp), %rdx
	leaq	-1040(%rbp), %rax
	movq	%rcx, %r8
	movq	%rdx, %rcx
	leaq	.LC15(%rip), %rdx
	movl	$1024, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	snprintf@PLT
	leaq	-1040(%rbp), %rax
	movl	$1, %esi
	movq	%rax, %rdi
	call	access@PLT
	testl	%eax, %eax
	jne	.L42
	leaq	-1040(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC18(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L42:
	leaq	.LC14(%rip), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	strtok@PLT
	movq	%rax, -1056(%rbp)
.L41:
	cmpq	$0, -1056(%rbp)
	jne	.L43
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L44
	call	__stack_chk_fail@PLT
.L44:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	suggest_command, .-suggest_command
	.section	.rodata
.LC19:
	.string	"./bitsh"
.LC20:
	.string	"SHELL"
.LC21:
	.string	"$ "
.LC22:
	.string	" \n"
.LC23:
	.string	"%s"
.LC24:
	.string	"Exiting shell...."
	.align 8
.LC25:
	.string	"bitsh: memory allocation error"
.LC26:
	.string	"Alias: %s -> %s\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$120, %rsp
	.cfi_offset 3, -24
	movl	%edi, -116(%rbp)
	movq	%rsi, -128(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movl	$1, %edx
	leaq	.LC19(%rip), %rax
	movq	%rax, %rsi
	leaq	.LC20(%rip), %rax
	movq	%rax, %rdi
	call	setenv@PLT
	leaq	.LC21(%rip), %rax
	movq	%rax, -56(%rbp)
	movq	$0, -88(%rbp)
	movq	$0, -80(%rbp)
	movq	$0, -72(%rbp)
	leaq	.LC22(%rip), %rax
	movq	%rax, -48(%rbp)
	movl	$0, -100(%rbp)
.L63:
	movq	-56(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC23(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdin(%rip), %rdx
	leaq	-80(%rbp), %rcx
	leaq	-88(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	getline@PLT
	movq	%rax, -40(%rbp)
	cmpq	$-1, -40(%rbp)
	jne	.L46
	leaq	.LC24(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L47
.L46:
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -72(%rbp)
	cmpq	$0, -72(%rbp)
	jne	.L48
	leaq	.LC25(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	jmp	.L47
.L48:
	movq	-88(%rbp), %rdx
	movq	-72(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movq	-88(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	%rax, -64(%rbp)
	jmp	.L49
.L50:
	addl	$1, -100(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	strtok@PLT
	movq	%rax, -64(%rbp)
.L49:
	cmpq	$0, -64(%rbp)
	jne	.L50
	addl	$1, -100(%rbp)
	movl	-100(%rbp), %eax
	cltq
	salq	$3, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -128(%rbp)
	cmpq	$0, -128(%rbp)
	jne	.L51
	leaq	.LC25(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movq	-88(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L47
.L51:
	movq	-48(%rbp), %rdx
	movq	-72(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	%rax, -64(%rbp)
	movl	$0, -96(%rbp)
	jmp	.L52
.L57:
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	addq	$1, %rax
	movl	-96(%rbp), %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,8), %rcx
	movq	-128(%rbp), %rdx
	leaq	(%rcx,%rdx), %rbx
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, (%rbx)
	movl	-96(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-128(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L53
	leaq	.LC25(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movq	-88(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	$0, -92(%rbp)
	jmp	.L54
.L55:
	movl	-92(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-128(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free@PLT
	addl	$1, -92(%rbp)
.L54:
	movl	-92(%rbp), %eax
	cmpl	-96(%rbp), %eax
	jl	.L55
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L56
.L53:
	movl	-96(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-128(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	-64(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movq	-48(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	strtok@PLT
	movq	%rax, -64(%rbp)
	addl	$1, -96(%rbp)
.L52:
	cmpq	$0, -64(%rbp)
	jne	.L57
.L56:
	movl	-96(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-128(%rbp), %rax
	addq	%rdx, %rax
	movq	$0, (%rax)
	movq	-128(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	get_alias
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	je	.L58
	movq	-128(%rbp), %rax
	movq	(%rax), %rax
	movq	-32(%rbp), %rdx
	movq	%rax, %rsi
	leaq	.LC26(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-48(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	-128(%rbp), %rdx
	movq	%rax, (%rdx)
.L58:
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	execute_builtin
	cmpl	$-1, %eax
	je	.L66
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	execute_external
	testl	%eax, %eax
	jne	.L60
	movq	-128(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	suggest_command
	jmp	.L47
.L60:
	movl	$0, -96(%rbp)
	jmp	.L61
.L62:
	movl	-96(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-128(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free@PLT
	addl	$1, -96(%rbp)
.L61:
	movl	-96(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-128(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L62
	jmp	.L63
.L66:
	nop
.L47:
	movl	$0, %eax
	call	free_aliases
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-88(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	$0, %eax
	movq	-24(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L65
	call	__stack_chk_fail@PLT
.L65:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.ident	"GCC: (GNU) 14.2.1 20250207"
	.section	.note.GNU-stack,"",@progbits
