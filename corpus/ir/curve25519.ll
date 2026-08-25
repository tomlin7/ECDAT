; ModuleID = '/workspace/corpus/src/curve25519.c'
source_filename = "/workspace/corpus/src/curve25519.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@curve25519_clamp = internal constant [4 x i8] c"\F8\FF\FF\FF", align 1
@curve25519_p = internal constant [4 x i32] [i32 -19, i32 -1, i32 -1, i32 2147483647], align 16
@curve25519_basepoint = internal constant <{ i8, [31 x i8] }> <{ i8 9, [31 x i8] zeroinitializer }>, align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @curve25519_scalarmult(ptr noundef %out, ptr noundef %scalar, ptr noundef %point) #0 {
entry:
  %out.addr = alloca ptr, align 8
  %scalar.addr = alloca ptr, align 8
  %point.addr = alloca ptr, align 8
  store ptr %out, ptr %out.addr, align 8
  store ptr %scalar, ptr %scalar.addr, align 8
  store ptr %point, ptr %point.addr, align 8
  %0 = load ptr, ptr %scalar.addr, align 8
  %arrayidx = getelementptr inbounds i8, ptr %0, i64 0
  %1 = load i8, ptr %arrayidx, align 1
  %conv = zext i8 %1 to i32
  %2 = load i8, ptr @curve25519_clamp, align 1
  %conv1 = zext i8 %2 to i32
  %and = and i32 %conv, %conv1
  %conv2 = trunc i32 %and to i8
  %3 = load ptr, ptr %out.addr, align 8
  %arrayidx3 = getelementptr inbounds i8, ptr %3, i64 0
  store i8 %conv2, ptr %arrayidx3, align 1
  %4 = load ptr, ptr %point.addr, align 8
  %arrayidx4 = getelementptr inbounds i8, ptr %4, i64 0
  %5 = load i8, ptr %arrayidx4, align 1
  %conv5 = zext i8 %5 to i32
  %6 = load i8, ptr @curve25519_basepoint, align 16
  %conv6 = zext i8 %6 to i32
  %xor = xor i32 %conv5, %conv6
  %conv7 = trunc i32 %xor to i8
  %7 = load ptr, ptr %out.addr, align 8
  %arrayidx8 = getelementptr inbounds i8, ptr %7, i64 1
  store i8 %conv7, ptr %arrayidx8, align 1
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
