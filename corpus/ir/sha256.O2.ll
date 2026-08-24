; ModuleID = '/workspace/corpus/src/sha256.c'
source_filename = "/workspace/corpus/src/sha256.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@K = internal unnamed_addr constant [64 x i32] [i32 1116352408, i32 1899447441, i32 -1245643825, i32 -373957723, i32 961987163, i32 1508970993, i32 -1841331548, i32 -1424204075, i32 -670586216, i32 310598401, i32 607225278, i32 1426881987, i32 1925078388, i32 -2132889090, i32 -1680079193, i32 -1046744716, i32 -459576895, i32 -272742522, i32 264347078, i32 604807628, i32 770255983, i32 1249150122, i32 1555081692, i32 1996064986, i32 -1740746414, i32 -1473132947, i32 -1341970488, i32 -1084653625, i32 -958395405, i32 -710438585, i32 113926993, i32 338241895, i32 666307205, i32 773529912, i32 1294757372, i32 1396182291, i32 1695183700, i32 1986661051, i32 -2117940946, i32 -1838011259, i32 -1564481375, i32 -1474664885, i32 -1035236496, i32 -949202525, i32 -778901479, i32 -694614492, i32 -200395387, i32 275423344, i32 430227734, i32 506948616, i32 659060556, i32 883997877, i32 958139571, i32 1322822218, i32 1537002063, i32 1747873779, i32 1955562222, i32 2024104815, i32 -2067236844, i32 -1933114872, i32 -1866530822, i32 -1538233109, i32 -1090935817, i32 -965641998], align 16

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @sha256_compress(ptr nocapture noundef %state, ptr nocapture noundef readonly %block) local_unnamed_addr #0 {
entry:
  %w = alloca [64 x i32], align 16
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %w) #3
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
  %arrayidx20 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %indvars.iv
  store i32 %or18, ptr %arrayidx20, align 4, !tbaa !8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 16
  br i1 %exitcond.not, label %for.body26.preheader, label %for.body, !llvm.loop !10

for.body26.preheader:                             ; preds = %for.body
  %.pre = load i32, ptr %w, align 16, !tbaa !8
  br label %for.body26

for.cond.cleanup25:                               ; preds = %for.body26
  %8 = load i32, ptr %state, align 4, !tbaa !8
  %arrayidx66 = getelementptr inbounds i32, ptr %state, i64 1
  %9 = load i32, ptr %arrayidx66, align 4, !tbaa !8
  %arrayidx67 = getelementptr inbounds i32, ptr %state, i64 2
  %10 = load i32, ptr %arrayidx67, align 4, !tbaa !8
  %arrayidx68 = getelementptr inbounds i32, ptr %state, i64 3
  %11 = load i32, ptr %arrayidx68, align 4, !tbaa !8
  %arrayidx69 = getelementptr inbounds i32, ptr %state, i64 4
  %12 = load i32, ptr %arrayidx69, align 4, !tbaa !8
  %arrayidx70 = getelementptr inbounds i32, ptr %state, i64 5
  %13 = load i32, ptr %arrayidx70, align 4, !tbaa !8
  %arrayidx71 = getelementptr inbounds i32, ptr %state, i64 6
  %14 = load i32, ptr %arrayidx71, align 4, !tbaa !8
  %arrayidx72 = getelementptr inbounds i32, ptr %state, i64 7
  %15 = load i32, ptr %arrayidx72, align 4, !tbaa !8
  br label %for.body78

for.body26:                                       ; preds = %for.body26.preheader, %for.body26
  %16 = phi i32 [ %.pre, %for.body26.preheader ], [ %18, %for.body26 ]
  %indvars.iv232 = phi i64 [ 16, %for.body26.preheader ], [ %indvars.iv.next233, %for.body26 ]
  %17 = add nsw i64 %indvars.iv232, -15
  %arrayidx28 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %17
  %18 = load i32, ptr %arrayidx28, align 4, !tbaa !8
  %or.i = tail call i32 @llvm.fshl.i32(i32 %18, i32 %18, i32 25)
  %or.i191 = tail call i32 @llvm.fshl.i32(i32 %18, i32 %18, i32 14)
  %xor = xor i32 %or.i, %or.i191
  %shr = lshr i32 %18, 3
  %xor36 = xor i32 %xor, %shr
  %19 = add nsw i64 %indvars.iv232, -2
  %arrayidx39 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %19
  %20 = load i32, ptr %arrayidx39, align 4, !tbaa !8
  %or.i194 = tail call i32 @llvm.fshl.i32(i32 %20, i32 %20, i32 15)
  %or.i197 = tail call i32 @llvm.fshl.i32(i32 %20, i32 %20, i32 13)
  %xor45 = xor i32 %or.i194, %or.i197
  %shr49 = lshr i32 %20, 10
  %xor50 = xor i32 %xor45, %shr49
  %add54 = add i32 %xor36, %16
  %21 = add nsw i64 %indvars.iv232, -7
  %arrayidx57 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %21
  %22 = load i32, ptr %arrayidx57, align 4, !tbaa !8
  %add58 = add i32 %add54, %22
  %add59 = add i32 %add58, %xor50
  %arrayidx61 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %indvars.iv232
  store i32 %add59, ptr %arrayidx61, align 4, !tbaa !8
  %indvars.iv.next233 = add nuw nsw i64 %indvars.iv232, 1
  %exitcond239.not = icmp eq i64 %indvars.iv.next233, 64
  br i1 %exitcond239.not, label %for.cond.cleanup25, label %for.body26, !llvm.loop !12

for.cond.cleanup77:                               ; preds = %for.body78
  %add111 = add i32 %add106, %8
  store i32 %add111, ptr %state, align 4, !tbaa !8
  %add113 = add i32 %a.0226, %9
  store i32 %add113, ptr %arrayidx66, align 4, !tbaa !8
  %add115 = add i32 %b.0225, %10
  store i32 %add115, ptr %arrayidx67, align 4, !tbaa !8
  %add117 = add i32 %c.0224, %11
  store i32 %add117, ptr %arrayidx68, align 4, !tbaa !8
  %add119 = add i32 %add105, %12
  store i32 %add119, ptr %arrayidx69, align 4, !tbaa !8
  %add121 = add i32 %e.0218, %13
  store i32 %add121, ptr %arrayidx70, align 4, !tbaa !8
  %add123 = add i32 %f.0219, %14
  store i32 %add123, ptr %arrayidx71, align 4, !tbaa !8
  %add125 = add i32 %g.0220, %15
  store i32 %add125, ptr %arrayidx72, align 4, !tbaa !8
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %w) #3
  ret void

for.body78:                                       ; preds = %for.cond.cleanup25, %for.body78
  %indvars.iv240 = phi i64 [ 0, %for.cond.cleanup25 ], [ %indvars.iv.next241, %for.body78 ]
  %a.0226 = phi i32 [ %8, %for.cond.cleanup25 ], [ %add106, %for.body78 ]
  %b.0225 = phi i32 [ %9, %for.cond.cleanup25 ], [ %a.0226, %for.body78 ]
  %c.0224 = phi i32 [ %10, %for.cond.cleanup25 ], [ %b.0225, %for.body78 ]
  %d.0223 = phi i32 [ %11, %for.cond.cleanup25 ], [ %c.0224, %for.body78 ]
  %h.0221 = phi i32 [ %15, %for.cond.cleanup25 ], [ %g.0220, %for.body78 ]
  %g.0220 = phi i32 [ %14, %for.cond.cleanup25 ], [ %f.0219, %for.body78 ]
  %f.0219 = phi i32 [ %13, %for.cond.cleanup25 ], [ %e.0218, %for.body78 ]
  %e.0218 = phi i32 [ %12, %for.cond.cleanup25 ], [ %add105, %for.body78 ]
  %or.i200 = tail call i32 @llvm.fshl.i32(i32 %e.0218, i32 %e.0218, i32 26)
  %or.i203 = tail call i32 @llvm.fshl.i32(i32 %e.0218, i32 %e.0218, i32 21)
  %xor81 = xor i32 %or.i200, %or.i203
  %or.i206 = tail call i32 @llvm.fshl.i32(i32 %e.0218, i32 %e.0218, i32 7)
  %xor83 = xor i32 %xor81, %or.i206
  %and = and i32 %f.0219, %e.0218
  %not = xor i32 %e.0218, -1
  %and84 = and i32 %g.0220, %not
  %arrayidx89 = getelementptr inbounds [64 x i32], ptr @K, i64 0, i64 %indvars.iv240
  %23 = load i32, ptr %arrayidx89, align 4, !tbaa !8
  %arrayidx92 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %indvars.iv240
  %24 = load i32, ptr %arrayidx92, align 4, !tbaa !8
  %xor85 = add i32 %xor83, %and
  %add86 = add i32 %xor85, %h.0221
  %add87 = add i32 %add86, %and84
  %add90 = add i32 %add87, %23
  %add93 = add i32 %add90, %24
  %or.i209 = tail call i32 @llvm.fshl.i32(i32 %a.0226, i32 %a.0226, i32 30)
  %or.i212 = tail call i32 @llvm.fshl.i32(i32 %a.0226, i32 %a.0226, i32 19)
  %xor96 = xor i32 %or.i209, %or.i212
  %or.i215 = tail call i32 @llvm.fshl.i32(i32 %a.0226, i32 %a.0226, i32 10)
  %xor98 = xor i32 %xor96, %or.i215
  %and100188 = xor i32 %b.0225, %c.0224
  %xor101 = and i32 %a.0226, %and100188
  %and102 = and i32 %b.0225, %c.0224
  %xor103 = xor i32 %xor101, %and102
  %add104 = add i32 %xor98, %xor103
  %add105 = add i32 %add93, %d.0223
  %add106 = add i32 %add104, %add93
  %indvars.iv.next241 = add nuw nsw i64 %indvars.iv240, 1
  %exitcond243.not = icmp eq i64 %indvars.iv.next241, 64
  br i1 %exitcond243.not, label %for.cond.cleanup77, label %for.body78, !llvm.loop !13
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
!10 = distinct !{!10, !11}
!11 = !{!"llvm.loop.mustprogress"}
!12 = distinct !{!12, !11}
!13 = distinct !{!13, !11}
