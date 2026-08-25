; ModuleID = '/workspace/corpus/src/hmac.c'
source_filename = "/workspace/corpus/src/hmac.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sha256_k = internal constant [64 x i32] [i32 1116352408, i32 1899447441, i32 -1245643825, i32 -373957723, i32 961987163, i32 1508970993, i32 -1841331548, i32 -1424204075, i32 -670586216, i32 310598401, i32 607225278, i32 1426881987, i32 1925078388, i32 -2132889090, i32 -1680079193, i32 -1046744716, i32 -459576895, i32 -272742522, i32 264347078, i32 604807628, i32 770255983, i32 1249150122, i32 1555081692, i32 1996064986, i32 -1740746414, i32 -1473132947, i32 -1341970488, i32 -1084653625, i32 -958395405, i32 -710438585, i32 113926993, i32 338241895, i32 666307205, i32 773529912, i32 1294757372, i32 1396182291, i32 1695183700, i32 1986661051, i32 -2117940946, i32 -1838011259, i32 -1564481375, i32 -1474664885, i32 -1035236496, i32 -949202525, i32 -778901479, i32 -694614492, i32 -200395387, i32 275423344, i32 430227734, i32 506948616, i32 659060556, i32 883997877, i32 958139571, i32 1322822218, i32 1537002063, i32 1747873779, i32 1955562222, i32 2024104815, i32 -2067236844, i32 -1933114872, i32 -1866530822, i32 -1538233109, i32 -1090935817, i32 -965641998], align 16
@hmac_ipad = internal constant [64 x i8] c"6666666666666666666666666666666666666666666666666666666666666666", align 16
@hmac_opad = internal constant [64 x i8] c"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\", align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @hmac_sha256_compress(ptr noundef %state, ptr noundef %block) #0 {
entry:
  %state.addr = alloca ptr, align 8
  %block.addr = alloca ptr, align 8
  %i = alloca i32, align 4
  %i3 = alloca i32, align 4
  %i13 = alloca i32, align 4
  store ptr %state, ptr %state.addr, align 8
  store ptr %block, ptr %block.addr, align 8
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 8
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32, ptr %i, align 4
  %mul = mul nsw i32 %1, 4
  %idxprom = sext i32 %mul to i64
  %arrayidx = getelementptr inbounds [64 x i8], ptr @hmac_ipad, i64 0, i64 %idxprom
  %2 = load i8, ptr %arrayidx, align 1
  %conv = zext i8 %2 to i32
  %shl = shl i32 %conv, 24
  %3 = load ptr, ptr %state.addr, align 8
  %4 = load i32, ptr %i, align 4
  %idxprom1 = sext i32 %4 to i64
  %arrayidx2 = getelementptr inbounds i32, ptr %3, i64 %idxprom1
  %5 = load i32, ptr %arrayidx2, align 4
  %xor = xor i32 %5, %shl
  store i32 %xor, ptr %arrayidx2, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %6 = load i32, ptr %i, align 4
  %inc = add nsw i32 %6, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  store i32 0, ptr %i3, align 4
  br label %for.cond4

for.cond4:                                        ; preds = %for.inc10, %for.end
  %7 = load i32, ptr %i3, align 4
  %cmp5 = icmp slt i32 %7, 64
  br i1 %cmp5, label %for.body7, label %for.end12

for.body7:                                        ; preds = %for.cond4
  %8 = load ptr, ptr %block.addr, align 8
  %9 = load i32, ptr %i3, align 4
  %idxprom8 = sext i32 %9 to i64
  %arrayidx9 = getelementptr inbounds i8, ptr %8, i64 %idxprom8
  %10 = load i8, ptr %arrayidx9, align 1
  br label %for.inc10

for.inc10:                                        ; preds = %for.body7
  %11 = load i32, ptr %i3, align 4
  %inc11 = add nsw i32 %11, 1
  store i32 %inc11, ptr %i3, align 4
  br label %for.cond4, !llvm.loop !8

for.end12:                                        ; preds = %for.cond4
  store i32 0, ptr %i13, align 4
  br label %for.cond14

for.cond14:                                       ; preds = %for.inc26, %for.end12
  %12 = load i32, ptr %i13, align 4
  %cmp15 = icmp slt i32 %12, 8
  br i1 %cmp15, label %for.body17, label %for.end28

for.body17:                                       ; preds = %for.cond14
  %13 = load i32, ptr %i13, align 4
  %mul18 = mul nsw i32 %13, 4
  %idxprom19 = sext i32 %mul18 to i64
  %arrayidx20 = getelementptr inbounds [64 x i8], ptr @hmac_opad, i64 0, i64 %idxprom19
  %14 = load i8, ptr %arrayidx20, align 1
  %conv21 = zext i8 %14 to i32
  %shl22 = shl i32 %conv21, 24
  %15 = load ptr, ptr %state.addr, align 8
  %16 = load i32, ptr %i13, align 4
  %idxprom23 = sext i32 %16 to i64
  %arrayidx24 = getelementptr inbounds i32, ptr %15, i64 %idxprom23
  %17 = load i32, ptr %arrayidx24, align 4
  %xor25 = xor i32 %17, %shl22
  store i32 %xor25, ptr %arrayidx24, align 4
  br label %for.inc26

for.inc26:                                        ; preds = %for.body17
  %18 = load i32, ptr %i13, align 4
  %inc27 = add nsw i32 %18, 1
  store i32 %inc27, ptr %i13, align 4
  br label %for.cond14, !llvm.loop !9

for.end28:                                        ; preds = %for.cond14
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
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
