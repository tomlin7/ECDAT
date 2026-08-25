; ModuleID = '/workspace/corpus/src/curve25519.c'
source_filename = "/workspace/corpus/src/curve25519.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable
define dso_local void @curve25519_scalarmult(ptr nocapture noundef writeonly %out, ptr nocapture noundef readonly %scalar, ptr nocapture noundef readonly %point) local_unnamed_addr #0 {
entry:
  %0 = load i8, ptr %scalar, align 1, !tbaa !5
  %1 = and i8 %0, -8
  store i8 %1, ptr %out, align 1, !tbaa !5
  %2 = load i8, ptr %point, align 1, !tbaa !5
  %3 = xor i8 %2, 9
  %arrayidx8 = getelementptr inbounds i8, ptr %out, i64 1
  store i8 %3, ptr %arrayidx8, align 1, !tbaa !5
  ret void
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
