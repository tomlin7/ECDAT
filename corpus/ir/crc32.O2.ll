; ModuleID = '/workspace/corpus/src/crc32.c'
source_filename = "/workspace/corpus/src/crc32.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read) uwtable
define dso_local i32 @crc32_ieee(ptr nocapture noundef readonly %data, i32 noundef %n) local_unnamed_addr #0 {
entry:
  %cmp19 = icmp sgt i32 %n, 0
  br i1 %cmp19, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %wide.trip.count = zext nneg i32 %n to i64
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  %0 = xor i32 %op.rdx24, -1
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  %crc.0.lcssa = phi i32 [ 0, %entry ], [ %0, %for.cond.cleanup.loopexit ]
  ret i32 %crc.0.lcssa

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
  %crc.021 = phi i32 [ -1, %for.body.preheader ], [ %op.rdx24, %for.body ]
  %arrayidx = getelementptr inbounds i8, ptr %data, i64 %indvars.iv
  %1 = load i8, ptr %arrayidx, align 1, !tbaa !5
  %conv = zext i8 %1 to i32
  %xor = xor i32 %crc.021, %conv
  %and = and i32 %xor, 1
  %shr = lshr i32 %xor, 1
  %2 = icmp eq i32 %and, 0
  %and6 = select i1 %2, i32 0, i32 -306674912
  %xor7 = xor i32 %and6, %shr
  %shr.1 = lshr i32 %xor7, 1
  %3 = and i32 %xor, 2
  %4 = icmp eq i32 %3, 0
  %and6.1 = select i1 %4, i32 0, i32 -306674912
  %xor7.1 = xor i32 %and6.1, %shr.1
  %shr.2 = lshr i32 %xor7.1, 6
  %5 = insertelement <4 x i32> poison, i32 %xor, i64 0
  %6 = shufflevector <4 x i32> %5, <4 x i32> poison, <4 x i32> zeroinitializer
  %7 = and <4 x i32> %6, <i32 4, i32 8, i32 16, i32 32>
  %8 = icmp eq <4 x i32> %7, zeroinitializer
  %9 = select <4 x i1> %8, <4 x i32> zeroinitializer, <4 x i32> <i32 124634137, i32 249268274, i32 498536548, i32 997073096>
  %10 = and i32 %xor7, 32
  %11 = icmp eq i32 %10, 0
  %and6.6 = select i1 %11, i32 0, i32 1994146192
  %12 = and i32 %xor7.1, 32
  %13 = icmp eq i32 %12, 0
  %and6.7 = select i1 %13, i32 0, i32 -306674912
  %14 = tail call i32 @llvm.vector.reduce.xor.v4i32(<4 x i32> %9)
  %op.rdx = xor i32 %14, %and6.6
  %op.rdx23 = xor i32 %and6.7, %shr.2
  %op.rdx24 = xor i32 %op.rdx, %op.rdx23
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %for.cond.cleanup.loopexit, label %for.body, !llvm.loop !8
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.xor.v4i32(<4 x i32>) #1

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: read) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

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
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
