	.syntax unified
	.arch armv7-a
	.text
	.align 4
	.global vfp_baseline
	.type vfp_baseline, function

vfp_baseline:
	@ PROLOG
	push {r4, r5, r6,lr}
	
	@r4->0.0 , r5->1.0, r6->n 
	@s0->pi ,s1->1.0 ,s2->delta(1.0/dt) ,s3->x 
	@s4->i ,s5->down ,s6->dt ,s7->all ,s8->4.0

	mov r4, #0
	vmov s0, r4
	vmov s4, r4
	vcvt.f32.u32 s0, s0  @s0 =(float)r4
	vcvt.f32.u32 s4, s4  @s4 =(float)r4
	
	
	mov r5, #1
	vmov s1, r5
	vcvt.f32.u32 s1, s1  @s1 =(float)r5
	 
	mov r5, #4
	vmov s8, r5
	vcvt.f32.u32 s8, s8  @s8 =(float)r5

	mov r6, r0
	vmov s6, r6
	vcvt.f32.u32 s6, s6  @s6 =(float)r6
	
	vdiv.f32 s2, s1, s6  @ delta = 1.0/dt

.loop:
		
	vdiv.f32 s3, s4, s6  @ float x = (float)i/dt 
	vmul.f32 s3, s3, s3  @ x = x * x
	vadd.f32 s5, s1, s3  @ down = 1.0 + x * x
	vdiv.f32 s7, s2, s5  @ all = delta/down
	vadd.f32 s0, s0, s7
	vadd.f32 s4, s4, s1
	subs r6, #1  @i--
	bgt .loop
	
	vmul.f32 s8, s8, s0
	vmov.f32 s0,s8      @if return float is return(s0) 
	
	pop {r4, r5, r6, pc}		@EPILOG
	.size vfp_baseline, .-vfp_baseline
	.end

