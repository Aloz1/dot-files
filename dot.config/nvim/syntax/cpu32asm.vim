" Vim syntax file
" Language:	CPU32 Assembler
" Last Change:	2019/09/11

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

setlocal iskeyword=a-z,A-Z,48-57,.,_
"setlocal isident=a-z,A-Z,48-57,.,_
syn case ignore

syn keyword cpuRegister	r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 r13 r14
syn keyword cpuRegister	r15 r16 r17 r18 r19 r20 r21 r22 r23 r24 r25 r26 r27
syn keyword cpuRegister r28 r29 r30 r31 ccr sp
syn keyword cpuInstr	add sub mul and or eor ror neg swap
syn keyword cpuInstr	com end mov movh
syn keyword cpuInstr	ld ld.b ld.w ld.l st st.b st.w st.l
syn keyword cpuInstr	bra bsr bcs bcc bvs bvc bmi bpl blo bhi bls bhs beq
syn keyword cpuInstr	bne ble bge blt bgt jmp rts

syn keyword cpuDirective ascii byte long word rmb dc.b dc.w dc.l ds.b ds.w ds.l
syn keyword cpuDirective align block org text data global xdef extern xref
syn keyword cpuDirective reg equ

syn match	cpuNumericOperator	"[+-/*]"

" numbers
syn match	cpuDecNumber		"\(\(\d[ \t]*\)\@<![+-]\)\?\<[0-9]*\>"
syn match	cpuHexNumber		"\(\(\d[ \t]*\)\@<![+-]\)\?\$\<[0-9a-fA-F]\+\>"
syn match	cpuBinNumber		"\(\(\d[ \t]*\)\@<![+-]\)\?%\<[01]\+\>"
"syn match	cpuOctNumber		\"\<0[oO][0-7]\+\>\"

syn region	cpuComment		start=";" end="$"
syn region	cpuString		start="\"" end="\"\|$"
syn region	cpuString		start="'" end="'\|$"
syn match	cpuSymbol		"[()|\[\]:]"
syn match	cpuSpecial		"[#,]"
syn match	cpuLabel		"^\h\w*:\?"

hi def link	cpuHexNumber		cpuNumber
"hi def link	cpuOctNumber		cpuNumber
hi def link	cpuBinNumber		cpuNumber
hi def link	cpuDecNumber		cpuNumber

hi def link	cpuNumericOperator	cpuOperator

"  link to standard syn groups so the 'colorschemes' work:
hi def link	cpuOperator	operator
hi def link	cpuComment	comment
hi def link	cpuDirective	preproc
hi def link	cpuRegister	identifier
hi def link	cpuNumber	constant
hi def link	cpuSymbol	structure
hi def link	cpuString	string
hi def link	cpuInstr	keyword
hi def link	cpuLabel	label

let b:current_syntax = "cpu32asm"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8 sw=8 noet:
