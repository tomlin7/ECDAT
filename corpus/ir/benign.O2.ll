; ModuleID = '/workspace/corpus/src/benign.c'
source_filename = "/workspace/corpus/src/benign.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read) uwtable
define dso_local i32 @inventory_sum(ptr nocapture noundef readonly %items, i32 noundef %n) local_unnamed_addr #0 {
entry:
  %cmp4 = icmp sgt i32 %n, 0
  br i1 %cmp4, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %wide.trip.count = zext nneg i32 %n to i64
  %min.iters.check = icmp ult i32 %n, 8
  br i1 %min.iters.check, label %for.body.preheader10, label %vector.ph

vector.ph:                                        ; preds = %for.body.preheader
  %n.vec = and i64 %wide.trip.count, 2147483640
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <4 x i32> [ zeroinitializer, %vector.ph ], [ %2, %vector.body ]
  %vec.phi8 = phi <4 x i32> [ zeroinitializer, %vector.ph ], [ %3, %vector.body ]
  %0 = getelementptr inbounds i32, ptr %items, i64 %index
  %1 = getelementptr inbounds i32, ptr %0, i64 4
  %wide.load = load <4 x i32>, ptr %0, align 4, !tbaa !5
  %wide.load9 = load <4 x i32>, ptr %1, align 4, !tbaa !5
  %2 = add <4 x i32> %wide.load, %vec.phi
  %3 = add <4 x i32> %wide.load9, %vec.phi8
  %index.next = add nuw i64 %index, 8
  %4 = icmp eq i64 %index.next, %n.vec
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !9

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <4 x i32> %3, %2
  %5 = tail call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %bin.rdx)
  %cmp.n = icmp eq i64 %n.vec, %wide.trip.count
  br i1 %cmp.n, label %for.cond.cleanup, label %for.body.preheader10

for.body.preheader10:                             ; preds = %for.body.preheader, %middle.block
  %indvars.iv.ph = phi i64 [ 0, %for.body.preheader ], [ %n.vec, %middle.block ]
  %total.05.ph = phi i32 [ 0, %for.body.preheader ], [ %5, %middle.block ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %entry
  %total.0.lcssa = phi i32 [ 0, %entry ], [ %5, %middle.block ], [ %add, %for.body ]
  ret i32 %total.0.lcssa

for.body:                                         ; preds = %for.body.preheader10, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ %indvars.iv.ph, %for.body.preheader10 ]
  %total.05 = phi i32 [ %add, %for.body ], [ %total.05.ph, %for.body.preheader10 ]
  %arrayidx = getelementptr inbounds i32, ptr %items, i64 %indvars.iv
  %6 = load i32, ptr %arrayidx, align 4, !tbaa !5
  %add = add nsw i32 %6, %total.05
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !13
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @copy_record(ptr nocapture noundef writeonly %dst, ptr nocapture noundef readonly %src, i32 noundef %n) local_unnamed_addr #1 {
entry:
  %cmp10 = icmp sgt i32 %n, 0
  br i1 %cmp10, label %iter.check, label %for.cond.cleanup

iter.check:                                       ; preds = %entry
  %dst13 = ptrtoint ptr %dst to i64
  %src14 = ptrtoint ptr %src to i64
  %wide.trip.count = zext nneg i32 %n to i64
  %min.iters.check = icmp ult i32 %n, 8
  %0 = sub i64 %dst13, %src14
  %diff.check = icmp ult i64 %0, 32
  %or.cond = or i1 %min.iters.check, %diff.check
  br i1 %or.cond, label %for.body.preheader, label %vector.main.loop.iter.check

vector.main.loop.iter.check:                      ; preds = %iter.check
  %min.iters.check15 = icmp ult i32 %n, 32
  br i1 %min.iters.check15, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %n.vec = and i64 %wide.trip.count, 2147483616
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %1 = getelementptr inbounds i8, ptr %src, i64 %index
  %2 = getelementptr inbounds i8, ptr %1, i64 16
  %wide.load = load <16 x i8>, ptr %1, align 1, !tbaa !14
  %wide.load16 = load <16 x i8>, ptr %2, align 1, !tbaa !14
  %3 = getelementptr inbounds i8, ptr %dst, i64 %index
  %4 = getelementptr inbounds i8, ptr %3, i64 16
  store <16 x i8> %wide.load, ptr %3, align 1, !tbaa !14
  store <16 x i8> %wide.load16, ptr %4, align 1, !tbaa !14
  %index.next = add nuw i64 %index, 32
  %5 = icmp eq i64 %index.next, %n.vec
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !15

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %n.vec, %wide.trip.count
  br i1 %cmp.n, label %for.cond.cleanup, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  %n.vec.remaining = and i64 %wide.trip.count, 24
  %min.epilog.iters.check = icmp eq i64 %n.vec.remaining, 0
  br i1 %min.epilog.iters.check, label %for.body.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %vec.epilog.resume.val = phi i64 [ %n.vec, %vec.epilog.iter.check ], [ 0, %vector.main.loop.iter.check ]
  %n.vec18 = and i64 %wide.trip.count, 2147483640
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index20 = phi i64 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next22, %vec.epilog.vector.body ]
  %6 = getelementptr inbounds i8, ptr %src, i64 %index20
  %wide.load21 = load <8 x i8>, ptr %6, align 1, !tbaa !14
  %7 = getelementptr inbounds i8, ptr %dst, i64 %index20
  store <8 x i8> %wide.load21, ptr %7, align 1, !tbaa !14
  %index.next22 = add nuw i64 %index20, 8
  %8 = icmp eq i64 %index.next22, %n.vec18
  br i1 %8, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !16

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %cmp.n19 = icmp eq i64 %n.vec18, %wide.trip.count
  br i1 %cmp.n19, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %indvars.iv.ph = phi i64 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec18, %vec.epilog.middle.block ]
  %xtraiter = and i64 %wide.trip.count, 3
  %lcmp.mod.not = icmp eq i64 %xtraiter, 0
  br i1 %lcmp.mod.not, label %for.body.prol.loopexit, label %for.body.prol

for.body.prol:                                    ; preds = %for.body.preheader, %for.body.prol
  %indvars.iv.prol = phi i64 [ %indvars.iv.next.prol, %for.body.prol ], [ %indvars.iv.ph, %for.body.preheader ]
  %prol.iter = phi i64 [ %prol.iter.next, %for.body.prol ], [ 0, %for.body.preheader ]
  %arrayidx.prol = getelementptr inbounds i8, ptr %src, i64 %indvars.iv.prol
  %9 = load i8, ptr %arrayidx.prol, align 1, !tbaa !14
  %arrayidx2.prol = getelementptr inbounds i8, ptr %dst, i64 %indvars.iv.prol
  store i8 %9, ptr %arrayidx2.prol, align 1, !tbaa !14
  %indvars.iv.next.prol = add nuw nsw i64 %indvars.iv.prol, 1
  %prol.iter.next = add i64 %prol.iter, 1
  %prol.iter.cmp.not = icmp eq i64 %prol.iter.next, %xtraiter
  br i1 %prol.iter.cmp.not, label %for.body.prol.loopexit, label %for.body.prol, !llvm.loop !17

for.body.prol.loopexit:                           ; preds = %for.body.prol, %for.body.preheader
  %indvars.iv.unr = phi i64 [ %indvars.iv.ph, %for.body.preheader ], [ %indvars.iv.next.prol, %for.body.prol ]
  %10 = sub nsw i64 %indvars.iv.ph, %wide.trip.count
  %11 = icmp ugt i64 %10, -4
  br i1 %11, label %for.cond.cleanup, label %for.body

for.cond.cleanup:                                 ; preds = %for.body.prol.loopexit, %for.body, %middle.block, %vec.epilog.middle.block, %entry
  %idxprom3 = sext i32 %n to i64
  %arrayidx4 = getelementptr inbounds i8, ptr %dst, i64 %idxprom3
  store i8 0, ptr %arrayidx4, align 1, !tbaa !14
  ret void

for.body:                                         ; preds = %for.body.prol.loopexit, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next.3, %for.body ], [ %indvars.iv.unr, %for.body.prol.loopexit ]
  %arrayidx = getelementptr inbounds i8, ptr %src, i64 %indvars.iv
  %12 = load i8, ptr %arrayidx, align 1, !tbaa !14
  %arrayidx2 = getelementptr inbounds i8, ptr %dst, i64 %indvars.iv
  store i8 %12, ptr %arrayidx2, align 1, !tbaa !14
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %arrayidx.1 = getelementptr inbounds i8, ptr %src, i64 %indvars.iv.next
  %13 = load i8, ptr %arrayidx.1, align 1, !tbaa !14
  %arrayidx2.1 = getelementptr inbounds i8, ptr %dst, i64 %indvars.iv.next
  store i8 %13, ptr %arrayidx2.1, align 1, !tbaa !14
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2
  %arrayidx.2 = getelementptr inbounds i8, ptr %src, i64 %indvars.iv.next.1
  %14 = load i8, ptr %arrayidx.2, align 1, !tbaa !14
  %arrayidx2.2 = getelementptr inbounds i8, ptr %dst, i64 %indvars.iv.next.1
  store i8 %14, ptr %arrayidx2.2, align 1, !tbaa !14
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv, 3
  %arrayidx.3 = getelementptr inbounds i8, ptr %src, i64 %indvars.iv.next.2
  %15 = load i8, ptr %arrayidx.3, align 1, !tbaa !14
  %arrayidx2.3 = getelementptr inbounds i8, ptr %dst, i64 %indvars.iv.next.2
  store i8 %15, ptr %arrayidx2.3, align 1, !tbaa !14
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv, 4
  %exitcond.not.3 = icmp eq i64 %indvars.iv.next.3, %wide.trip.count
  br i1 %exitcond.not.3, label %for.cond.cleanup, label %for.body, !llvm.loop !19
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read) uwtable
define dso_local i32 @find_parcel(ptr nocapture noundef readonly %ids, i32 noundef %n, i32 noundef %target) local_unnamed_addr #0 {
entry:
  %cmp.not5 = icmp sgt i32 %n, 0
  br i1 %cmp.not5, label %for.body.preheader, label %cleanup

for.body.preheader:                               ; preds = %entry
  %wide.trip.count = zext nneg i32 %n to i64
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.inc
  %indvars.iv = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next, %for.inc ]
  %arrayidx = getelementptr inbounds i32, ptr %ids, i64 %indvars.iv
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !5
  %cmp1 = icmp eq i32 %0, %target
  br i1 %cmp1, label %cleanup.loopexit.split.loop.exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %cleanup, label %for.body, !llvm.loop !20

cleanup.loopexit.split.loop.exit:                 ; preds = %for.body
  %1 = trunc i64 %indvars.iv to i32
  br label %cleanup

cleanup:                                          ; preds = %for.inc, %cleanup.loopexit.split.loop.exit, %entry
  %spec.select = phi i32 [ -1, %entry ], [ %1, %cleanup.loopexit.split.loop.exit ], [ -1, %for.inc ]
  ret i32 %spec.select
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v4i32(<4 x i32>) #2

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: read) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = distinct !{!9, !10, !11, !12}
!10 = !{!"llvm.loop.mustprogress"}
!11 = !{!"llvm.loop.isvectorized", i32 1}
!12 = !{!"llvm.loop.unroll.runtime.disable"}
!13 = distinct !{!13, !10, !12, !11}
!14 = !{!7, !7, i64 0}
!15 = distinct !{!15, !10, !11, !12}
!16 = distinct !{!16, !10, !11, !12}
!17 = distinct !{!17, !18}
!18 = !{!"llvm.loop.unroll.disable"}
!19 = distinct !{!19, !10, !11}
!20 = distinct !{!20, !10}
