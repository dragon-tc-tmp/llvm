; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512dq | FileCheck %s --check-prefix=ALL --check-prefix=AVX512 --check-prefix=AVX512DQ
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw | FileCheck %s --check-prefix=ALL --check-prefix=AVX512 --check-prefix=AVX512BW

;
; Variable Shifts
;

define <8 x i64> @var_shift_v8i64(<8 x i64> %a, <8 x i64> %b) nounwind {
; ALL-LABEL: var_shift_v8i64:
; ALL:       # %bb.0:
; ALL-NEXT:    vpsllvq %zmm1, %zmm0, %zmm0
; ALL-NEXT:    retq
  %shift = shl <8 x i64> %a, %b
  ret <8 x i64> %shift
}

define <16 x i32> @var_shift_v16i32(<16 x i32> %a, <16 x i32> %b) nounwind {
; ALL-LABEL: var_shift_v16i32:
; ALL:       # %bb.0:
; ALL-NEXT:    vpsllvd %zmm1, %zmm0, %zmm0
; ALL-NEXT:    retq
  %shift = shl <16 x i32> %a, %b
  ret <16 x i32> %shift
}

define <32 x i16> @var_shift_v32i16(<32 x i16> %a, <32 x i16> %b) nounwind {
; AVX512DQ-LABEL: var_shift_v32i16:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vpmovzxwd {{.*#+}} zmm2 = ymm2[0],zero,ymm2[1],zero,ymm2[2],zero,ymm2[3],zero,ymm2[4],zero,ymm2[5],zero,ymm2[6],zero,ymm2[7],zero,ymm2[8],zero,ymm2[9],zero,ymm2[10],zero,ymm2[11],zero,ymm2[12],zero,ymm2[13],zero,ymm2[14],zero,ymm2[15],zero
; AVX512DQ-NEXT:    vpmovzxwd {{.*#+}} zmm0 = ymm0[0],zero,ymm0[1],zero,ymm0[2],zero,ymm0[3],zero,ymm0[4],zero,ymm0[5],zero,ymm0[6],zero,ymm0[7],zero,ymm0[8],zero,ymm0[9],zero,ymm0[10],zero,ymm0[11],zero,ymm0[12],zero,ymm0[13],zero,ymm0[14],zero,ymm0[15],zero
; AVX512DQ-NEXT:    vpsllvd %zmm2, %zmm0, %zmm0
; AVX512DQ-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512DQ-NEXT:    vpmovzxwd {{.*#+}} zmm2 = ymm3[0],zero,ymm3[1],zero,ymm3[2],zero,ymm3[3],zero,ymm3[4],zero,ymm3[5],zero,ymm3[6],zero,ymm3[7],zero,ymm3[8],zero,ymm3[9],zero,ymm3[10],zero,ymm3[11],zero,ymm3[12],zero,ymm3[13],zero,ymm3[14],zero,ymm3[15],zero
; AVX512DQ-NEXT:    vpmovzxwd {{.*#+}} zmm1 = ymm1[0],zero,ymm1[1],zero,ymm1[2],zero,ymm1[3],zero,ymm1[4],zero,ymm1[5],zero,ymm1[6],zero,ymm1[7],zero,ymm1[8],zero,ymm1[9],zero,ymm1[10],zero,ymm1[11],zero,ymm1[12],zero,ymm1[13],zero,ymm1[14],zero,ymm1[15],zero
; AVX512DQ-NEXT:    vpsllvd %zmm2, %zmm1, %zmm1
; AVX512DQ-NEXT:    vpmovdw %zmm1, %ymm1
; AVX512DQ-NEXT:    retq
;
; AVX512BW-LABEL: var_shift_v32i16:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpsllvw %zmm1, %zmm0, %zmm0
; AVX512BW-NEXT:    retq
  %shift = shl <32 x i16> %a, %b
  ret <32 x i16> %shift
}

define <64 x i8> @var_shift_v64i8(<64 x i8> %a, <64 x i8> %b) nounwind {
; AVX512DQ-LABEL: var_shift_v64i8:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vpsllw $4, %ymm0, %ymm4
; AVX512DQ-NEXT:    vmovdqa {{.*#+}} ymm5 = [240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240]
; AVX512DQ-NEXT:    vpand %ymm5, %ymm4, %ymm4
; AVX512DQ-NEXT:    vpsllw $5, %ymm2, %ymm2
; AVX512DQ-NEXT:    vpblendvb %ymm2, %ymm4, %ymm0, %ymm0
; AVX512DQ-NEXT:    vpsllw $2, %ymm0, %ymm4
; AVX512DQ-NEXT:    vmovdqa {{.*#+}} ymm6 = [252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252]
; AVX512DQ-NEXT:    vpand %ymm6, %ymm4, %ymm4
; AVX512DQ-NEXT:    vpaddb %ymm2, %ymm2, %ymm2
; AVX512DQ-NEXT:    vpblendvb %ymm2, %ymm4, %ymm0, %ymm0
; AVX512DQ-NEXT:    vpaddb %ymm0, %ymm0, %ymm4
; AVX512DQ-NEXT:    vpaddb %ymm2, %ymm2, %ymm2
; AVX512DQ-NEXT:    vpblendvb %ymm2, %ymm4, %ymm0, %ymm0
; AVX512DQ-NEXT:    vpsllw $4, %ymm1, %ymm2
; AVX512DQ-NEXT:    vpand %ymm5, %ymm2, %ymm2
; AVX512DQ-NEXT:    vpsllw $5, %ymm3, %ymm3
; AVX512DQ-NEXT:    vpblendvb %ymm3, %ymm2, %ymm1, %ymm1
; AVX512DQ-NEXT:    vpsllw $2, %ymm1, %ymm2
; AVX512DQ-NEXT:    vpand %ymm6, %ymm2, %ymm2
; AVX512DQ-NEXT:    vpaddb %ymm3, %ymm3, %ymm3
; AVX512DQ-NEXT:    vpblendvb %ymm3, %ymm2, %ymm1, %ymm1
; AVX512DQ-NEXT:    vpaddb %ymm1, %ymm1, %ymm2
; AVX512DQ-NEXT:    vpaddb %ymm3, %ymm3, %ymm3
; AVX512DQ-NEXT:    vpblendvb %ymm3, %ymm2, %ymm1, %ymm1
; AVX512DQ-NEXT:    retq
;
; AVX512BW-LABEL: var_shift_v64i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpsllw $4, %zmm0, %zmm2
; AVX512BW-NEXT:    vpandq {{.*}}(%rip), %zmm2, %zmm2
; AVX512BW-NEXT:    vpsllw $5, %zmm1, %zmm1
; AVX512BW-NEXT:    vpmovb2m %zmm1, %k1
; AVX512BW-NEXT:    vmovdqu8 %zmm2, %zmm0 {%k1}
; AVX512BW-NEXT:    vpsllw $2, %zmm0, %zmm2
; AVX512BW-NEXT:    vpandq {{.*}}(%rip), %zmm2, %zmm2
; AVX512BW-NEXT:    vpaddb %zmm1, %zmm1, %zmm1
; AVX512BW-NEXT:    vpmovb2m %zmm1, %k1
; AVX512BW-NEXT:    vmovdqu8 %zmm2, %zmm0 {%k1}
; AVX512BW-NEXT:    vpaddb %zmm1, %zmm1, %zmm1
; AVX512BW-NEXT:    vpmovb2m %zmm1, %k1
; AVX512BW-NEXT:    vpaddb %zmm0, %zmm0, %zmm0 {%k1}
; AVX512BW-NEXT:    retq
  %shift = shl <64 x i8> %a, %b
  ret <64 x i8> %shift
}

;
; Uniform Variable Shifts
;

define <8 x i64> @splatvar_shift_v8i64(<8 x i64> %a, <8 x i64> %b) nounwind {
; ALL-LABEL: splatvar_shift_v8i64:
; ALL:       # %bb.0:
; ALL-NEXT:    vpsllq %xmm1, %zmm0, %zmm0
; ALL-NEXT:    retq
  %splat = shufflevector <8 x i64> %b, <8 x i64> undef, <8 x i32> zeroinitializer
  %shift = shl <8 x i64> %a, %splat
  ret <8 x i64> %shift
}

define <16 x i32> @splatvar_shift_v16i32(<16 x i32> %a, <16 x i32> %b) nounwind {
; ALL-LABEL: splatvar_shift_v16i32:
; ALL:       # %bb.0:
; ALL-NEXT:    vpmovzxdq {{.*#+}} xmm1 = xmm1[0],zero,xmm1[1],zero
; ALL-NEXT:    vpslld %xmm1, %zmm0, %zmm0
; ALL-NEXT:    retq
  %splat = shufflevector <16 x i32> %b, <16 x i32> undef, <16 x i32> zeroinitializer
  %shift = shl <16 x i32> %a, %splat
  ret <16 x i32> %shift
}

define <32 x i16> @splatvar_shift_v32i16(<32 x i16> %a, <32 x i16> %b) nounwind {
; AVX512DQ-LABEL: splatvar_shift_v32i16:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vpmovzxwq {{.*#+}} xmm2 = xmm2[0],zero,zero,zero,xmm2[1],zero,zero,zero
; AVX512DQ-NEXT:    vpsllw %xmm2, %ymm0, %ymm0
; AVX512DQ-NEXT:    vpsllw %xmm2, %ymm1, %ymm1
; AVX512DQ-NEXT:    retq
;
; AVX512BW-LABEL: splatvar_shift_v32i16:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpmovzxwq {{.*#+}} xmm1 = xmm1[0],zero,zero,zero,xmm1[1],zero,zero,zero
; AVX512BW-NEXT:    vpsllw %xmm1, %zmm0, %zmm0
; AVX512BW-NEXT:    retq
  %splat = shufflevector <32 x i16> %b, <32 x i16> undef, <32 x i32> zeroinitializer
  %shift = shl <32 x i16> %a, %splat
  ret <32 x i16> %shift
}

define <64 x i8> @splatvar_shift_v64i8(<64 x i8> %a, <64 x i8> %b) nounwind {
; AVX512DQ-LABEL: splatvar_shift_v64i8:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vpmovzxbq {{.*#+}} xmm2 = xmm2[0],zero,zero,zero,zero,zero,zero,zero,xmm2[1],zero,zero,zero,zero,zero,zero,zero
; AVX512DQ-NEXT:    vpsllw %xmm2, %ymm0, %ymm0
; AVX512DQ-NEXT:    vpcmpeqd %ymm3, %ymm3, %ymm3
; AVX512DQ-NEXT:    vpsllw %xmm2, %ymm3, %ymm3
; AVX512DQ-NEXT:    vpbroadcastb %xmm3, %ymm3
; AVX512DQ-NEXT:    vpand %ymm3, %ymm0, %ymm0
; AVX512DQ-NEXT:    vpsllw %xmm2, %ymm1, %ymm1
; AVX512DQ-NEXT:    vpand %ymm3, %ymm1, %ymm1
; AVX512DQ-NEXT:    retq
;
; AVX512BW-LABEL: splatvar_shift_v64i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpmovzxbq {{.*#+}} xmm1 = xmm1[0],zero,zero,zero,zero,zero,zero,zero,xmm1[1],zero,zero,zero,zero,zero,zero,zero
; AVX512BW-NEXT:    vpsllw %xmm1, %zmm0, %zmm0
; AVX512BW-NEXT:    vpternlogd $255, %zmm2, %zmm2, %zmm2
; AVX512BW-NEXT:    vpsllw %xmm1, %zmm2, %zmm1
; AVX512BW-NEXT:    vpbroadcastb %xmm1, %zmm1
; AVX512BW-NEXT:    vpandq %zmm1, %zmm0, %zmm0
; AVX512BW-NEXT:    retq
  %splat = shufflevector <64 x i8> %b, <64 x i8> undef, <64 x i32> zeroinitializer
  %shift = shl <64 x i8> %a, %splat
  ret <64 x i8> %shift
}

;
; Constant Shifts
;

define <8 x i64> @constant_shift_v8i64(<8 x i64> %a) nounwind {
; ALL-LABEL: constant_shift_v8i64:
; ALL:       # %bb.0:
; ALL-NEXT:    vpsllvq {{.*}}(%rip), %zmm0, %zmm0
; ALL-NEXT:    retq
  %shift = shl <8 x i64> %a, <i64 1, i64 7, i64 31, i64 62, i64 1, i64 7, i64 31, i64 62>
  ret <8 x i64> %shift
}

define <16 x i32> @constant_shift_v16i32(<16 x i32> %a) nounwind {
; ALL-LABEL: constant_shift_v16i32:
; ALL:       # %bb.0:
; ALL-NEXT:    vpsllvd {{.*}}(%rip), %zmm0, %zmm0
; ALL-NEXT:    retq
  %shift = shl <16 x i32> %a, <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 8, i32 7, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 8, i32 7>
  ret <16 x i32> %shift
}

define <32 x i16> @constant_shift_v32i16(<32 x i16> %a) nounwind {
; AVX512DQ-LABEL: constant_shift_v32i16:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vmovdqa {{.*#+}} ymm2 = [1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768]
; AVX512DQ-NEXT:    vpmullw %ymm2, %ymm0, %ymm0
; AVX512DQ-NEXT:    vpmullw %ymm2, %ymm1, %ymm1
; AVX512DQ-NEXT:    retq
;
; AVX512BW-LABEL: constant_shift_v32i16:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpsllvw {{.*}}(%rip), %zmm0, %zmm0
; AVX512BW-NEXT:    retq
  %shift = shl <32 x i16> %a, <i16 0, i16 1, i16 2, i16 3, i16 4, i16 5, i16 6, i16 7, i16 8, i16 9, i16 10, i16 11, i16 12, i16 13, i16 14, i16 15, i16 0, i16 1, i16 2, i16 3, i16 4, i16 5, i16 6, i16 7, i16 8, i16 9, i16 10, i16 11, i16 12, i16 13, i16 14, i16 15>
  ret <32 x i16> %shift
}

define <64 x i8> @constant_shift_v64i8(<64 x i8> %a) nounwind {
; AVX512DQ-LABEL: constant_shift_v64i8:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vpsllw $4, %ymm0, %ymm2
; AVX512DQ-NEXT:    vmovdqa {{.*#+}} ymm3 = [240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240]
; AVX512DQ-NEXT:    vpand %ymm3, %ymm2, %ymm2
; AVX512DQ-NEXT:    vmovdqa {{.*#+}} ymm4 = [8192,24640,41088,57536,49376,32928,16480,32,8192,24640,41088,57536,49376,32928,16480,32]
; AVX512DQ-NEXT:    vpblendvb %ymm4, %ymm2, %ymm0, %ymm0
; AVX512DQ-NEXT:    vpsllw $2, %ymm0, %ymm2
; AVX512DQ-NEXT:    vmovdqa {{.*#+}} ymm5 = [252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252,252]
; AVX512DQ-NEXT:    vpand %ymm5, %ymm2, %ymm2
; AVX512DQ-NEXT:    vpaddb %ymm4, %ymm4, %ymm6
; AVX512DQ-NEXT:    vpblendvb %ymm6, %ymm2, %ymm0, %ymm0
; AVX512DQ-NEXT:    vpaddb %ymm0, %ymm0, %ymm2
; AVX512DQ-NEXT:    vpaddb %ymm6, %ymm6, %ymm7
; AVX512DQ-NEXT:    vpblendvb %ymm7, %ymm2, %ymm0, %ymm0
; AVX512DQ-NEXT:    vpsllw $4, %ymm1, %ymm2
; AVX512DQ-NEXT:    vpand %ymm3, %ymm2, %ymm2
; AVX512DQ-NEXT:    vpblendvb %ymm4, %ymm2, %ymm1, %ymm1
; AVX512DQ-NEXT:    vpsllw $2, %ymm1, %ymm2
; AVX512DQ-NEXT:    vpand %ymm5, %ymm2, %ymm2
; AVX512DQ-NEXT:    vpblendvb %ymm6, %ymm2, %ymm1, %ymm1
; AVX512DQ-NEXT:    vpaddb %ymm1, %ymm1, %ymm2
; AVX512DQ-NEXT:    vpblendvb %ymm7, %ymm2, %ymm1, %ymm1
; AVX512DQ-NEXT:    retq
;
; AVX512BW-LABEL: constant_shift_v64i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa64 {{.*#+}} zmm1 = [8192,24640,41088,57536,49376,32928,16480,32,8192,24640,41088,57536,49376,32928,16480,32,8192,24640,41088,57536,49376,32928,16480,32,8192,24640,41088,57536,49376,32928,16480,32]
; AVX512BW-NEXT:    vpmovb2m %zmm1, %k1
; AVX512BW-NEXT:    vpsllw $4, %zmm0, %zmm2
; AVX512BW-NEXT:    vpandq {{.*}}(%rip), %zmm2, %zmm2
; AVX512BW-NEXT:    vmovdqu8 %zmm2, %zmm0 {%k1}
; AVX512BW-NEXT:    vpsllw $2, %zmm0, %zmm2
; AVX512BW-NEXT:    vpandq {{.*}}(%rip), %zmm2, %zmm2
; AVX512BW-NEXT:    vpaddb %zmm1, %zmm1, %zmm1
; AVX512BW-NEXT:    vpmovb2m %zmm1, %k1
; AVX512BW-NEXT:    vmovdqu8 %zmm2, %zmm0 {%k1}
; AVX512BW-NEXT:    vpaddb %zmm1, %zmm1, %zmm1
; AVX512BW-NEXT:    vpmovb2m %zmm1, %k1
; AVX512BW-NEXT:    vpaddb %zmm0, %zmm0, %zmm0 {%k1}
; AVX512BW-NEXT:    retq
  %shift = shl <64 x i8> %a, <i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 7, i8 6, i8 5, i8 4, i8 3, i8 2, i8 1, i8 0, i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 7, i8 6, i8 5, i8 4, i8 3, i8 2, i8 1, i8 0, i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 7, i8 6, i8 5, i8 4, i8 3, i8 2, i8 1, i8 0, i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 7, i8 6, i8 5, i8 4, i8 3, i8 2, i8 1, i8 0>
  ret <64 x i8> %shift
}

;
; Uniform Constant Shifts
;

define <8 x i64> @splatconstant_shift_v8i64(<8 x i64> %a) nounwind {
; ALL-LABEL: splatconstant_shift_v8i64:
; ALL:       # %bb.0:
; ALL-NEXT:    vpsllq $7, %zmm0, %zmm0
; ALL-NEXT:    retq
  %shift = shl <8 x i64> %a, <i64 7, i64 7, i64 7, i64 7, i64 7, i64 7, i64 7, i64 7>
  ret <8 x i64> %shift
}

define <16 x i32> @splatconstant_shift_v16i32(<16 x i32> %a) nounwind {
; ALL-LABEL: splatconstant_shift_v16i32:
; ALL:       # %bb.0:
; ALL-NEXT:    vpslld $5, %zmm0, %zmm0
; ALL-NEXT:    retq
  %shift = shl <16 x i32> %a, <i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5>
  ret <16 x i32> %shift
}

define <32 x i16> @splatconstant_shift_v32i16(<32 x i16> %a) nounwind {
; AVX512DQ-LABEL: splatconstant_shift_v32i16:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vpsllw $3, %ymm0, %ymm0
; AVX512DQ-NEXT:    vpsllw $3, %ymm1, %ymm1
; AVX512DQ-NEXT:    retq
;
; AVX512BW-LABEL: splatconstant_shift_v32i16:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpsllw $3, %zmm0, %zmm0
; AVX512BW-NEXT:    retq
  %shift = shl <32 x i16> %a, <i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3>
  ret <32 x i16> %shift
}

define <64 x i8> @splatconstant_shift_v64i8(<64 x i8> %a) nounwind {
; AVX512DQ-LABEL: splatconstant_shift_v64i8:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vpsllw $3, %ymm0, %ymm0
; AVX512DQ-NEXT:    vmovdqa {{.*#+}} ymm2 = [248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248]
; AVX512DQ-NEXT:    vpand %ymm2, %ymm0, %ymm0
; AVX512DQ-NEXT:    vpsllw $3, %ymm1, %ymm1
; AVX512DQ-NEXT:    vpand %ymm2, %ymm1, %ymm1
; AVX512DQ-NEXT:    retq
;
; AVX512BW-LABEL: splatconstant_shift_v64i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpsllw $3, %zmm0, %zmm0
; AVX512BW-NEXT:    vpandq {{.*}}(%rip), %zmm0, %zmm0
; AVX512BW-NEXT:    retq
  %shift = shl <64 x i8> %a, <i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3>
  ret <64 x i8> %shift
}
