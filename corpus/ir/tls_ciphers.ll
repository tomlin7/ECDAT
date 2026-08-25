; ModuleID = '/workspace/corpus/src/tls_ciphers.c'
source_filename = "/workspace/corpus/src/tls_ciphers.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@tls_cipher_suites = internal constant [8 x i16] [i16 4865, i16 4866, i16 4867, i16 -16337, i16 -16336, i16 -13144, i16 156, i16 157], align 16
@tls_record_version = internal constant [2 x i8] c"\03\03", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @tls_default_ciphers(ptr noundef %n) #0 {
entry:
  %n.addr = alloca ptr, align 8
  store ptr %n, ptr %n.addr, align 8
  %0 = load ptr, ptr %n.addr, align 8
  store i32 8, ptr %0, align 4
  ret ptr @tls_cipher_suites
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @tls_record_proto() #0 {
entry:
  ret ptr @tls_record_version
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
