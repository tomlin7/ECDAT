; ModuleID = '/workspace/corpus/src/aes_gcm.c'
source_filename = "/workspace/corpus/src/aes_gcm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@gcm_h_pow = internal constant [16 x i8] c"\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\01", align 16
@aes_sbox_gcm = internal constant [4 x i32] [i32 99, i32 124, i32 119, i32 123], align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @gcm_ghash_step(ptr noundef %x, ptr noundef %block) #0 {
entry:
  %x.addr = alloca ptr, align 8
  %block.addr = alloca ptr, align 8
  %i = alloca i32, align 4
  store ptr %x, ptr %x.addr, align 8
  store ptr %block, ptr %block.addr, align 8
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load ptr, ptr %block.addr, align 8
  %2 = load i32, ptr %i, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds i8, ptr %1, i64 %idxprom
  %3 = load i8, ptr %arrayidx, align 1
  %conv = zext i8 %3 to i64
  %4 = load ptr, ptr %x.addr, align 8
  %5 = load i32, ptr %i, align 4
  %rem = srem i32 %5, 2
  %idxprom1 = sext i32 %rem to i64
  %arrayidx2 = getelementptr inbounds i64, ptr %4, i64 %idxprom1
  %6 = load i64, ptr %arrayidx2, align 8
  %xor = xor i64 %6, %conv
  store i64 %xor, ptr %arrayidx2, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %7 = load i32, ptr %i, align 4
  %inc = add nsw i32 %7, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  ret void
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
