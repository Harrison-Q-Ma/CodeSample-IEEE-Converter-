/*
 * File Name: parseNum.s
 * Author: Qixuan "Harrison" Ma
 * Date: 4 September 2020
 */ 
	.arch 	armv6 			@ Specify hardware to assembler
	.cpu 	cortex-a53 
	.syntax unified 

	.extern	strtoul
	.global parseNum
	.equ	FP_OFFSET, 	4	@ Stack frame setup
	.equ 	HEXBASE, 	16 	@ Constant 16 to indicate hexdecimal 
	.equ	NULL, 		0x0	@ NULL pointer

	.text				@ declare label main as function
	.type 	parseNum, %function
/*
 * <unsigned long parseNum( char * argv[] )> 
 *
 * Registers used: 
 * 	r4 - local - temporarily store argv[2] 
 * 	r1 - local - value to pass into strtoul(NULL) 
 * 	r2 - local - value to pass into strtoul, indicate hexdecimal
 *
 * Stack variables: 
 * 	None
 */
parseNum: 
	push 	{fp, lr} 		@ Function stack frame prologue
	add 	fp, sp, FP_OFFSET

	add 	r0, r0, 8
	ldr 	r0, [r0]
	/*
	ldr 	r4, [r0,8]
	mov 	r0, r4
	*/
	mov 	r1, NULL		@ Set r1 to be NULL for strtoul	
	mov 	r2, HEXBASE 		@ Set r2 to be base 16

	bl 	strtoul			@ Call strtoul(r0,r1,r2)
					@ Output is stored in r0
	b 	done 			@ Branch to done (unsigned int parsed)
done: 
	sub 	sp, fp, FP_OFFSET 	@ Restore stack frame
	pop 	{fp, lr} 		@ Remove stack frame
	bx 	lr 
.end
