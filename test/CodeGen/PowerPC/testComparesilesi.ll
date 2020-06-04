; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu -O2 \
; RUN:   -ppc-gpr-icmps=all -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s --check-prefix=CHECK-BE \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu -O2 \
; RUN:   -ppc-gpr-icmps=all -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s --check-prefix=CHECK-LE \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl
@glob = common local_unnamed_addr global i32 0, align 4

define signext i32 @test_ilesi(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: test_ilesi:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub r3, r4, r3
; CHECK-NEXT:    rldicl r3, r3, 1, 63
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    blr
; CHECK-BE-LABEL: test_ilesi:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    sub r3, r4, r3
; CHECK-BE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-BE-NEXT:    xori r3, r3, 1
; CHECK-BE-NEXT:    blr
;
; CHECK-LE-LABEL: test_ilesi:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    sub r3, r4, r3
; CHECK-LE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-LE-NEXT:    xori r3, r3, 1
; CHECK-LE-NEXT:    blr
entry:
  %cmp = icmp sle i32 %a, %b
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define signext i32 @test_ilesi_sext(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: test_ilesi_sext:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub r3, r4, r3
; CHECK-NEXT:    rldicl r3, r3, 1, 63
; CHECK-NEXT:    addi r3, r3, -1
; CHECK-NEXT:    blr
; CHECK-BE-LABEL: test_ilesi_sext:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    sub r3, r4, r3
; CHECK-BE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-BE-NEXT:    addi r3, r3, -1
; CHECK-BE-NEXT:    blr
;
; CHECK-LE-LABEL: test_ilesi_sext:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    sub r3, r4, r3
; CHECK-LE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-LE-NEXT:    addi r3, r3, -1
; CHECK-LE-NEXT:    blr
entry:
  %cmp = icmp sle i32 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define void @test_ilesi_store(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: test_ilesi_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub r3, r4, r3
; CHECK-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-NEXT:    rldicl r3, r3, 1, 63
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    stw r3, glob@toc@l(r5)
; CHECK-NEXT:    blr
; CHECK-BE-LABEL: test_ilesi_store:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    addis r5, r2, .LC0@toc@ha
; CHECK-BE-NEXT:    sub r3, r4, r3
; CHECK-BE-NEXT:    ld r4, .LC0@toc@l(r5)
; CHECK-BE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-BE-NEXT:    xori r3, r3, 1
; CHECK-BE-NEXT:    stw r3, 0(r4)
; CHECK-BE-NEXT:    blr
;
; CHECK-LE-LABEL: test_ilesi_store:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    sub r3, r4, r3
; CHECK-LE-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-LE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-LE-NEXT:    xori r3, r3, 1
; CHECK-LE-NEXT:    stw r3, glob@toc@l(r5)
; CHECK-LE-NEXT:    blr
entry:
  %cmp = icmp sle i32 %a, %b
  %conv = zext i1 %cmp to i32
  store i32 %conv, i32* @glob, align 4
  ret void
}

define void @test_ilesi_sext_store(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: test_ilesi_sext_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub r3, r4, r3
; CHECK-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-NEXT:    rldicl r3, r3, 1, 63
; CHECK-NEXT:    addi r3, r3, -1
; CHECK-NEXT:    stw r3, glob@toc@l(r5)
; CHECK-NEXT:    blr
; CHECK-BE-LABEL: test_ilesi_sext_store:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    addis r5, r2, .LC0@toc@ha
; CHECK-BE-NEXT:    sub r3, r4, r3
; CHECK-BE-NEXT:    ld r4, .LC0@toc@l(r5)
; CHECK-BE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-BE-NEXT:    addi r3, r3, -1
; CHECK-BE-NEXT:    stw r3, 0(r4)
; CHECK-BE-NEXT:    blr
;
; CHECK-LE-LABEL: test_ilesi_sext_store:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    sub r3, r4, r3
; CHECK-LE-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-LE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-LE-NEXT:    addi r3, r3, -1
; CHECK-LE-NEXT:    stw r3, glob@toc@l(r5)
; CHECK-LE-NEXT:    blr
entry:
  %cmp = icmp sle i32 %a, %b
  %sub = sext i1 %cmp to i32
  store i32 %sub, i32* @glob, align 4
  ret void
}
