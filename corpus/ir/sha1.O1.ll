; ModuleID = '/workspace/corpus/src/sha1.c'
source_filename = "/workspace/corpus/src/sha1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @sha1_compress(ptr nocapture noundef %state, ptr nocapture noundef readonly %block) local_unnamed_addr #0 {
entry:
  %w = alloca [80 x i32], align 16
  call void @llvm.lifetime.start.p0(i64 320, ptr nonnull %w) #3
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %0 = shl nuw nsw i64 %indvars.iv, 2
  %arrayidx = getelementptr inbounds i8, ptr %block, i64 %0
  %1 = load i8, ptr %arrayidx, align 1, !tbaa !5
  %conv = zext i8 %1 to i32
  %shl = shl nuw i32 %conv, 24
  %2 = or disjoint i64 %0, 1
  %arrayidx3 = getelementptr inbounds i8, ptr %block, i64 %2
  %3 = load i8, ptr %arrayidx3, align 1, !tbaa !5
  %conv4 = zext i8 %3 to i32
  %shl5 = shl nuw nsw i32 %conv4, 16
  %or = or disjoint i32 %shl5, %shl
  %4 = or disjoint i64 %0, 2
  %arrayidx9 = getelementptr inbounds i8, ptr %block, i64 %4
  %5 = load i8, ptr %arrayidx9, align 1, !tbaa !5
  %conv10 = zext i8 %5 to i32
  %shl11 = shl nuw nsw i32 %conv10, 8
  %or12 = or disjoint i32 %or, %shl11
  %6 = or disjoint i64 %0, 3
  %arrayidx16 = getelementptr inbounds i8, ptr %block, i64 %6
  %7 = load i8, ptr %arrayidx16, align 1, !tbaa !5
  %conv17 = zext i8 %7 to i32
  %or18 = or disjoint i32 %or12, %conv17
  %arrayidx20 = getelementptr inbounds [80 x i32], ptr %w, i64 0, i64 %indvars.iv
  store i32 %or18, ptr %arrayidx20, align 4, !tbaa !8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 16
  br i1 %exitcond.not, label %for.body26, label %for.body, !llvm.loop !10

for.cond.cleanup25:                               ; preds = %for.body26
  %8 = load i32, ptr %state, align 4, !tbaa !8
  %arrayidx46 = getelementptr inbounds i32, ptr %state, i64 1
  %9 = load i32, ptr %arrayidx46, align 4, !tbaa !8
  %arrayidx47 = getelementptr inbounds i32, ptr %state, i64 2
  %10 = load i32, ptr %arrayidx47, align 4, !tbaa !8
  %arrayidx48 = getelementptr inbounds i32, ptr %state, i64 3
  %11 = load i32, ptr %arrayidx48, align 4, !tbaa !8
  %arrayidx49 = getelementptr inbounds i32, ptr %state, i64 4
  %12 = load i32, ptr %arrayidx49, align 4, !tbaa !8
  br label %for.body55

for.body26:                                       ; preds = %for.body, %for.body26
  %indvars.iv171 = phi i64 [ %indvars.iv.next172, %for.body26 ], [ 16, %for.body ]
  %13 = add nsw i64 %indvars.iv171, -3
  %arrayidx28 = getelementptr inbounds [80 x i32], ptr %w, i64 0, i64 %13
  %14 = load i32, ptr %arrayidx28, align 4, !tbaa !8
  %15 = add nsw i64 %indvars.iv171, -8
  %arrayidx31 = getelementptr inbounds [80 x i32], ptr %w, i64 0, i64 %15
  %16 = load i32, ptr %arrayidx31, align 4, !tbaa !8
  %xor = xor i32 %16, %14
  %17 = add nsw i64 %indvars.iv171, -14
  %arrayidx34 = getelementptr inbounds [80 x i32], ptr %w, i64 0, i64 %17
  %18 = load i32, ptr %arrayidx34, align 4, !tbaa !8
  %xor35 = xor i32 %xor, %18
  %19 = add nsw i64 %indvars.iv171, -16
  %arrayidx38 = getelementptr inbounds [80 x i32], ptr %w, i64 0, i64 %19
  %20 = load i32, ptr %arrayidx38, align 4, !tbaa !8
  %xor39 = xor i32 %xor35, %20
  %or.i = tail call i32 @llvm.fshl.i32(i32 %xor39, i32 %xor39, i32 1)
  %arrayidx41 = getelementptr inbounds [80 x i32], ptr %w, i64 0, i64 %indvars.iv171
  store i32 %or.i, ptr %arrayidx41, align 4, !tbaa !8
  %indvars.iv.next172 = add nuw nsw i64 %indvars.iv171, 1
  %exitcond178.not = icmp eq i64 %indvars.iv.next172, 80
  br i1 %exitcond178.not, label %for.cond.cleanup25, label %for.body26, !llvm.loop !13

for.cond.cleanup54:                               ; preds = %if.end78
  %add91 = add i32 %add85, %8
  store i32 %add91, ptr %state, align 4, !tbaa !8
  %add93 = add i32 %a.0160, %9
  store i32 %add93, ptr %arrayidx46, align 4, !tbaa !8
  %add95 = add i32 %or.i157, %10
  store i32 %add95, ptr %arrayidx47, align 4, !tbaa !8
  %add97 = add i32 %c.0162, %11
  store i32 %add97, ptr %arrayidx48, align 4, !tbaa !8
  %add99 = add i32 %d.0163, %12
  store i32 %add99, ptr %arrayidx49, align 4, !tbaa !8
  call void @llvm.lifetime.end.p0(i64 320, ptr nonnull %w) #3
  ret void

for.body55:                                       ; preds = %for.cond.cleanup25, %if.end78
  %indvars.iv179 = phi i64 [ 0, %for.cond.cleanup25 ], [ %indvars.iv.next180, %if.end78 ]
  %e.0164 = phi i32 [ %12, %for.cond.cleanup25 ], [ %d.0163, %if.end78 ]
  %d.0163 = phi i32 [ %11, %for.cond.cleanup25 ], [ %c.0162, %if.end78 ]
  %c.0162 = phi i32 [ %10, %for.cond.cleanup25 ], [ %or.i157, %if.end78 ]
  %b.0161 = phi i32 [ %9, %for.cond.cleanup25 ], [ %a.0160, %if.end78 ]
  %a.0160 = phi i32 [ %8, %for.cond.cleanup25 ], [ %add85, %if.end78 ]
  %cmp56 = icmp ult i64 %indvars.iv179, 20
  br i1 %cmp56, label %if.then, label %if.else

if.then:                                          ; preds = %for.body55
  %and = and i32 %c.0162, %b.0161
  %not = xor i32 %b.0161, -1
  %and58 = and i32 %d.0163, %not
  %or59 = or i32 %and58, %and
  br label %if.end78

if.else:                                          ; preds = %for.body55
  %cmp60 = icmp ult i64 %indvars.iv179, 40
  br i1 %cmp60, label %if.then62, label %if.else65

if.then62:                                        ; preds = %if.else
  %xor63 = xor i32 %c.0162, %b.0161
  %xor64 = xor i32 %xor63, %d.0163
  br label %if.end78

if.else65:                                        ; preds = %if.else
  %cmp66 = icmp ult i64 %indvars.iv179, 60
  br i1 %cmp66, label %if.then68, label %if.else74

if.then68:                                        ; preds = %if.else65
  %and70151 = or i32 %d.0163, %c.0162
  %or71 = and i32 %and70151, %b.0161
  %and72 = and i32 %d.0163, %c.0162
  %or73 = or i32 %or71, %and72
  br label %if.end78

if.else74:                                        ; preds = %if.else65
  %xor75 = xor i32 %c.0162, %b.0161
  %xor76 = xor i32 %xor75, %d.0163
  br label %if.end78

if.end78:                                         ; preds = %if.then62, %if.else74, %if.then68, %if.then
  %f.0 = phi i32 [ %or59, %if.then ], [ %xor64, %if.then62 ], [ %or73, %if.then68 ], [ %xor76, %if.else74 ]
  %k.0 = phi i32 [ 1518500249, %if.then ], [ 1859775393, %if.then62 ], [ -1894007588, %if.then68 ], [ -899497514, %if.else74 ]
  %or.i154 = tail call i32 @llvm.fshl.i32(i32 %a.0160, i32 %a.0160, i32 5)
  %arrayidx84 = getelementptr inbounds [80 x i32], ptr %w, i64 0, i64 %indvars.iv179
  %21 = load i32, ptr %arrayidx84, align 4, !tbaa !8
  %add80 = add i32 %e.0164, %or.i154
  %add81 = add i32 %add80, %f.0
  %add82 = add i32 %add81, %k.0
  %add85 = add i32 %add82, %21
  %or.i157 = tail call i32 @llvm.fshl.i32(i32 %b.0161, i32 %b.0161, i32 30)
  %indvars.iv.next180 = add nuw nsw i64 %indvars.iv179, 1
  %exitcond182.not = icmp eq i64 %indvars.iv.next180, 80
  br i1 %exitcond182.not, label %for.cond.cleanup54, label %for.body55, !llvm.loop !14
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.fshl.i32(i32, i32, i32) #2

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nounwind }

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
!14 = distinct !{!14, !11, !12}
