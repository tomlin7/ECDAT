; ModuleID = '/workspace/corpus/src/hmac.c'
source_filename = "/workspace/corpus/src/hmac.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@hmac_ipad = internal unnamed_addr constant [64 x i8] c"6666666666666666666666666666666666666666666666666666666666666666", align 16
@hmac_opad = internal unnamed_addr constant [64 x i8] c"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\", align 16

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @hmac_sha256_compress(ptr nocapture noundef %state, ptr nocapture noundef readnone %block) local_unnamed_addr #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %0 = shl nuw nsw i64 %indvars.iv, 2
  %arrayidx = getelementptr inbounds [64 x i8], ptr @hmac_ipad, i64 0, i64 %0
  %1 = load i8, ptr %arrayidx, align 4, !tbaa !5
  %conv = zext i8 %1 to i32
  %shl = shl nuw i32 %conv, 24
  %arrayidx2 = getelementptr inbounds i32, ptr %state, i64 %indvars.iv
  %2 = load i32, ptr %arrayidx2, align 4, !tbaa !8
  %xor = xor i32 %shl, %2
  store i32 %xor, ptr %arrayidx2, align 4, !tbaa !8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 8
  br i1 %exitcond.not, label %for.body19, label %for.body, !llvm.loop !10

for.cond.cleanup18:                               ; preds = %for.body19
  ret void

for.body19:                                       ; preds = %for.body, %for.body19
  %indvars.iv44 = phi i64 [ %indvars.iv.next45, %for.body19 ], [ 0, %for.body ]
  %3 = shl nuw nsw i64 %indvars.iv44, 2
  %arrayidx22 = getelementptr inbounds [64 x i8], ptr @hmac_opad, i64 0, i64 %3
  %4 = load i8, ptr %arrayidx22, align 4, !tbaa !5
  %conv23 = zext i8 %4 to i32
  %shl24 = shl nuw i32 %conv23, 24
  %arrayidx26 = getelementptr inbounds i32, ptr %state, i64 %indvars.iv44
  %5 = load i32, ptr %arrayidx26, align 4, !tbaa !8
  %xor27 = xor i32 %shl24, %5
  store i32 %xor27, ptr %arrayidx26, align 4, !tbaa !8
  %indvars.iv.next45 = add nuw nsw i64 %indvars.iv44, 1
  %exitcond48.not = icmp eq i64 %indvars.iv.next45, 8
  br i1 %exitcond48.not, label %for.cond.cleanup18, label %for.body19, !llvm.loop !13
}

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
!9 = !{!"int", !6, i64 0}
!10 = distinct !{!10, !11, !12}
!11 = !{!"llvm.loop.mustprogress"}
!12 = !{!"llvm.loop.unroll.disable"}
!13 = distinct !{!13, !11, !12}
