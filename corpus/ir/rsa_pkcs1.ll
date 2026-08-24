; ModuleID = '/workspace/corpus/src/rsa_pkcs1.c'
source_filename = "/workspace/corpus/src/rsa_pkcs1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@rsa_pkcs1_oid = internal constant [9 x i8] c"*\86H\86\F7\0D\01\01\01", align 1
@rsa_pubexp_65537 = internal constant [5 x i8] c"\02\03\01\00\01", align 1
@rsa_modulus_2048 = internal constant <{ [48 x i8], [208 x i8] }> <{ [48 x i8] c"\C4\8B\99!yn:D\1D\8E\9B/\0A|U\EE\91?(mK\17\82\FA3\09\BCq^$\8A`\01#Eg\89\AB\CD\EF\FE\DC\BA\98vT2\10", [208 x i8] zeroinitializer }>, align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @rsa_oid() #0 {
entry:
  ret ptr @rsa_pkcs1_oid
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @rsa_exponent() #0 {
entry:
  ret ptr @rsa_pubexp_65537
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @rsa_modulus() #0 {
entry:
  ret ptr @rsa_modulus_2048
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
