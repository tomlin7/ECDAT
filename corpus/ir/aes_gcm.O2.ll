; ModuleID = '/workspace/corpus/src/aes_gcm.c'
source_filename = "/workspace/corpus/src/aes_gcm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable
define dso_local void @gcm_ghash_step(ptr nocapture noundef %x, ptr nocapture noundef readonly %block) local_unnamed_addr #0 {
entry:
  %0 = load i8, ptr %block, align 1, !tbaa !5
  %conv = zext i8 %0 to i64
  %1 = load i64, ptr %x, align 8, !tbaa !8
  %xor = xor i64 %1, %conv
  store i64 %xor, ptr %x, align 8, !tbaa !8
  %arrayidx.1 = getelementptr inbounds i8, ptr %block, i64 1
  %2 = load i8, ptr %arrayidx.1, align 1, !tbaa !5
  %conv.1 = zext i8 %2 to i64
  %arrayidx2.1 = getelementptr inbounds i64, ptr %x, i64 1
  %3 = load i64, ptr %arrayidx2.1, align 8, !tbaa !8
  %xor.1 = xor i64 %3, %conv.1
  store i64 %xor.1, ptr %arrayidx2.1, align 8, !tbaa !8
  %arrayidx.2 = getelementptr inbounds i8, ptr %block, i64 2
  %4 = load i8, ptr %arrayidx.2, align 1, !tbaa !5
  %conv.2 = zext i8 %4 to i64
  %xor.2 = xor i64 %xor, %conv.2
  store i64 %xor.2, ptr %x, align 8, !tbaa !8
  %arrayidx.3 = getelementptr inbounds i8, ptr %block, i64 3
  %5 = load i8, ptr %arrayidx.3, align 1, !tbaa !5
  %conv.3 = zext i8 %5 to i64
  %xor.3 = xor i64 %xor.1, %conv.3
  store i64 %xor.3, ptr %arrayidx2.1, align 8, !tbaa !8
  %arrayidx.4 = getelementptr inbounds i8, ptr %block, i64 4
  %6 = load i8, ptr %arrayidx.4, align 1, !tbaa !5
  %conv.4 = zext i8 %6 to i64
  %xor.4 = xor i64 %xor.2, %conv.4
  store i64 %xor.4, ptr %x, align 8, !tbaa !8
  %arrayidx.5 = getelementptr inbounds i8, ptr %block, i64 5
  %7 = load i8, ptr %arrayidx.5, align 1, !tbaa !5
  %conv.5 = zext i8 %7 to i64
  %xor.5 = xor i64 %xor.3, %conv.5
  store i64 %xor.5, ptr %arrayidx2.1, align 8, !tbaa !8
  %arrayidx.6 = getelementptr inbounds i8, ptr %block, i64 6
  %8 = load i8, ptr %arrayidx.6, align 1, !tbaa !5
  %conv.6 = zext i8 %8 to i64
  %xor.6 = xor i64 %xor.4, %conv.6
  store i64 %xor.6, ptr %x, align 8, !tbaa !8
  %arrayidx.7 = getelementptr inbounds i8, ptr %block, i64 7
  %9 = load i8, ptr %arrayidx.7, align 1, !tbaa !5
  %conv.7 = zext i8 %9 to i64
  %xor.7 = xor i64 %xor.5, %conv.7
  store i64 %xor.7, ptr %arrayidx2.1, align 8, !tbaa !8
  %arrayidx.8 = getelementptr inbounds i8, ptr %block, i64 8
  %10 = load i8, ptr %arrayidx.8, align 1, !tbaa !5
  %conv.8 = zext i8 %10 to i64
  %xor.8 = xor i64 %xor.6, %conv.8
  store i64 %xor.8, ptr %x, align 8, !tbaa !8
  %arrayidx.9 = getelementptr inbounds i8, ptr %block, i64 9
  %11 = load i8, ptr %arrayidx.9, align 1, !tbaa !5
  %conv.9 = zext i8 %11 to i64
  %xor.9 = xor i64 %xor.7, %conv.9
  store i64 %xor.9, ptr %arrayidx2.1, align 8, !tbaa !8
  %arrayidx.10 = getelementptr inbounds i8, ptr %block, i64 10
  %12 = load i8, ptr %arrayidx.10, align 1, !tbaa !5
  %conv.10 = zext i8 %12 to i64
  %xor.10 = xor i64 %xor.8, %conv.10
  store i64 %xor.10, ptr %x, align 8, !tbaa !8
  %arrayidx.11 = getelementptr inbounds i8, ptr %block, i64 11
  %13 = load i8, ptr %arrayidx.11, align 1, !tbaa !5
  %conv.11 = zext i8 %13 to i64
  %xor.11 = xor i64 %xor.9, %conv.11
  store i64 %xor.11, ptr %arrayidx2.1, align 8, !tbaa !8
  %arrayidx.12 = getelementptr inbounds i8, ptr %block, i64 12
  %14 = load i8, ptr %arrayidx.12, align 1, !tbaa !5
  %conv.12 = zext i8 %14 to i64
  %xor.12 = xor i64 %xor.10, %conv.12
  store i64 %xor.12, ptr %x, align 8, !tbaa !8
  %arrayidx.13 = getelementptr inbounds i8, ptr %block, i64 13
  %15 = load i8, ptr %arrayidx.13, align 1, !tbaa !5
  %conv.13 = zext i8 %15 to i64
  %xor.13 = xor i64 %xor.11, %conv.13
  store i64 %xor.13, ptr %arrayidx2.1, align 8, !tbaa !8
  %arrayidx.14 = getelementptr inbounds i8, ptr %block, i64 14
  %16 = load i8, ptr %arrayidx.14, align 1, !tbaa !5
  %conv.14 = zext i8 %16 to i64
  %xor.14 = xor i64 %xor.12, %conv.14
  store i64 %xor.14, ptr %x, align 8, !tbaa !8
  %arrayidx.15 = getelementptr inbounds i8, ptr %block, i64 15
  %17 = load i8, ptr %arrayidx.15, align 1, !tbaa !5
  %conv.15 = zext i8 %17 to i64
  %xor.15 = xor i64 %xor.13, %conv.15
  store i64 %xor.15, ptr %arrayidx2.1, align 8, !tbaa !8
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
!8 = !{!9, !9, i64 0}
!9 = !{!"long", !6, i64 0}
