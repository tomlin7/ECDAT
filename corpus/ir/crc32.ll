; ModuleID = '/workspace/corpus/src/crc32.c'
source_filename = "/workspace/corpus/src/crc32.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @crc32_ieee(ptr noundef %data, i32 noundef %n) #0 {
entry:
  %data.addr = alloca ptr, align 8
  %n.addr = alloca i32, align 4
  %crc = alloca i32, align 4
  %i = alloca i32, align 4
  %b = alloca i32, align 4
  %mask = alloca i32, align 4
  store ptr %data, ptr %data.addr, align 8
  store i32 %n, ptr %n.addr, align 4
  store i32 -1, ptr %crc, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc7, %entry
  %0 = load i32, ptr %i, align 4
  %1 = load i32, ptr %n.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end9

for.body:                                         ; preds = %for.cond
  %2 = load ptr, ptr %data.addr, align 8
  %3 = load i32, ptr %i, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx = getelementptr inbounds i8, ptr %2, i64 %idxprom
  %4 = load i8, ptr %arrayidx, align 1
  %conv = zext i8 %4 to i32
  %5 = load i32, ptr %crc, align 4
  %xor = xor i32 %5, %conv
  store i32 %xor, ptr %crc, align 4
  store i32 0, ptr %b, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %6 = load i32, ptr %b, align 4
  %cmp2 = icmp slt i32 %6, 8
  br i1 %cmp2, label %for.body4, label %for.end

for.body4:                                        ; preds = %for.cond1
  %7 = load i32, ptr %crc, align 4
  %and = and i32 %7, 1
  %sub = sub nsw i32 0, %and
  store i32 %sub, ptr %mask, align 4
  %8 = load i32, ptr %crc, align 4
  %shr = lshr i32 %8, 1
  %9 = load i32, ptr %mask, align 4
  %and5 = and i32 -306674912, %9
  %xor6 = xor i32 %shr, %and5
  store i32 %xor6, ptr %crc, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body4
  %10 = load i32, ptr %b, align 4
  %inc = add nsw i32 %10, 1
  store i32 %inc, ptr %b, align 4
  br label %for.cond1, !llvm.loop !6

for.end:                                          ; preds = %for.cond1
  br label %for.inc7

for.inc7:                                         ; preds = %for.end
  %11 = load i32, ptr %i, align 4
  %inc8 = add nsw i32 %11, 1
  store i32 %inc8, ptr %i, align 4
  br label %for.cond, !llvm.loop !8

for.end9:                                         ; preds = %for.cond
  %12 = load i32, ptr %crc, align 4
  %not = xor i32 %12, -1
  ret i32 %not
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
