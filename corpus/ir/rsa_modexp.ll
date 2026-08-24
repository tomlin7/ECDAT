; ModuleID = '/workspace/corpus/src/rsa_modexp.c'
source_filename = "/workspace/corpus/src/rsa_modexp.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @rsa_modexp(i64 noundef %base, i64 noundef %exp, i64 noundef %mod) #0 {
entry:
  %base.addr = alloca i64, align 8
  %exp.addr = alloca i64, align 8
  %mod.addr = alloca i64, align 8
  %result = alloca i64, align 8
  store i64 %base, ptr %base.addr, align 8
  store i64 %exp, ptr %exp.addr, align 8
  store i64 %mod, ptr %mod.addr, align 8
  store i64 1, ptr %result, align 8
  %0 = load i64, ptr %mod.addr, align 8
  %1 = load i64, ptr %base.addr, align 8
  %rem = urem i64 %1, %0
  store i64 %rem, ptr %base.addr, align 8
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  %2 = load i64, ptr %exp.addr, align 8
  %cmp = icmp ugt i64 %2, 0
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %3 = load i64, ptr %exp.addr, align 8
  %and = and i64 %3, 1
  %tobool = icmp ne i64 %and, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %4 = load i64, ptr %result, align 8
  %5 = load i64, ptr %base.addr, align 8
  %mul = mul i64 %4, %5
  %6 = load i64, ptr %mod.addr, align 8
  %rem1 = urem i64 %mul, %6
  store i64 %rem1, ptr %result, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %while.body
  %7 = load i64, ptr %exp.addr, align 8
  %shr = lshr i64 %7, 1
  store i64 %shr, ptr %exp.addr, align 8
  %8 = load i64, ptr %base.addr, align 8
  %9 = load i64, ptr %base.addr, align 8
  %mul2 = mul i64 %8, %9
  %10 = load i64, ptr %mod.addr, align 8
  %rem3 = urem i64 %mul2, %10
  store i64 %rem3, ptr %base.addr, align 8
  br label %while.cond, !llvm.loop !6

while.end:                                        ; preds = %while.cond
  %11 = load i64, ptr %result, align 8
  ret i64 %11
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
