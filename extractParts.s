/*
 * Filename: extractParts.s
 * Author: Qixuan "Harrison" Ma
 * UserID: cs30s220bn
 * Date: 4 September 2020
 * Sources of help: Piazza posts and PA3 writeup
 */

	.arch 	armv6			@ Specify hardware to assembler
	.cpu 	cortex-a53		
	.syntax unified

	.global extractParts
	.equ 	FP_OFFSET, 	4 		@ Stack frame setup
	
	.equ 	R_SHIFT31, 	31		@ Right shift 31 byte
	.equ 	R_SHIFT24, 	24		@ Right shift 24 byte
	.equ 	R_SHIFT9, 	9 		@ Right shift 9 byte
	.equ 	L_SHIFT1, 	1 		@ Left shift 1 byte
	.equ 	L_SHIFT9, 	9 		@ Left shift 9 byte
	.equ 	EXP_BIAS, 	127		@ Exponent Bias
	.equ 	CHAR_LEN, 	1 		@ Size of the char type
	.equ 	LONG_LEN, 	4		@ Size of the Long type
	.equ 	HIDDENBIT, 	0x800000	@ Value of the "Hidden Bit" 

	.text
	.type 	extractParts, %function

/*
 * <void extractParts( unsigned long ieeeBin, ieeeParts_t * fill )> 
 *
 * Registers used: 
 *	r0 -- local -- store the data of ieeeBin input
 *	r1 -- local -- store the contents of the struct ieeeParts_t to 
 *	r2 -- local -- save the value to fill
 *
 * Stack variables: 
 * 	None
 */ 
extractParts: 
	push 	{fp, lr} 		@ Function stack fram prologue
	add 	fp, sp, FP_OFFSET

	lsr 	r2, r0, R_SHIFT31	@ Shift right by 31 bits
	strb 	r2, [r1] 		@ Store the value for sign to r2
	lsl 	r2, r0, L_SHIFT1	@ Shift left by 1 bits
	lsr 	r2, r2, R_SHIFT24	@ Shift Right by 24 bits
	sub 	r2, r2, EXP_BIAS	@ Subtract Exponent Bias from r2
	strb 	r2, [r1,CHAR_LEN] 	@ Store exponent data to r2
	lsl 	r2, r0, L_SHIFT9 	@ Shift left by 9 bits
	lsr 	r2, r2, R_SHIFT9 	@ Shift right by 9 bits
	add 	r2, r2, HIDDENBIT 	@ Add hidden bit to r2
	str 	r2, [r1, LONG_LEN] 	@ Store the value for mantissa to r2

	b 	done			@ Go to done section

done: 
	sub 	sp, fp, FP_OFFSET	@ Restore stack frame 
	pop 	{fp, lr} 		@ Remove stack frame
	bx 	lr 
.end

