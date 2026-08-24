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

for.cond.cleanup.loopexit:                        ; preds = %for.cond.cleanup4
  %0 = xor i32 %xor7, -1
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  %crc.0.lcssa = phi i32 [ 0, %entry ], [ %0, %for.cond.cleanup.loopexit ]
  ret i32 %crc.0.lcssa

for.body:                                         ; preds = %for.body.preheader, %for.cond.cleanup4
  %indvars.iv = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next, %for.cond.cleanup4 ]
  %crc.021 = phi i32 [ -1, %for.body.preheader ], [ %xor7, %for.cond.cleanup4 ]
  %arrayidx = getelementptr inbounds i8, ptr %data, i64 %indvars.iv
  %1 = load i8, ptr %arrayidx, align 1, !tbaa !5
  %conv = zext i8 %1 to i32
  %xor = xor i32 %crc.021, %conv
  br label %for.body5

for.cond.cleanup4:                                ; preds = %for.body5
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond23.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond23.not, label %for.cond.cleanup.loopexit, label %for.body, !llvm.loop !8

for.body5:                                        ; preds = %for.body, %for.body5
  %crc.118 = phi i32 [ %xor, %for.body ], [ %xor7, %for.body5 ]
  %b.017 = phi i32 [ 0, %for.body ], [ %inc, %for.body5 ]
  %and = and i32 %crc.118, 1
  %shr = lshr i32 %crc.118, 1
  %2 = icmp eq i32 %and, 0
  %and6 = select i1 %2, i32 0, i32 -306674912
  %xor7 = xor i32 %and6, %shr
  %inc = add nuw nsw i32 %b.017, 1
  %exitcond.not = icmp eq i32 %inc, 8
  br i1 %exitcond.not, label %for.cond.cleanup4, label %for.body5, !llvm.loop !11
}

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: read) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
!8 = distinct !{!8, !9, !10}
!9 = !{!"llvm.loop.mustprogress"}
!10 = !{!"llvm.loop.unroll.disable"}
!11 = distinct !{!11, !9, !10}
