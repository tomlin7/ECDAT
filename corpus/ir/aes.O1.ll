; ModuleID = '/workspace/corpus/src/aes.c'
source_filename = "/workspace/corpus/src/aes.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sbox = internal unnamed_addr constant [256 x i8] c"c|w{\F2ko\C50\01g+\FE\D7\ABv\CA\82\C9}\FAYG\F0\AD\D4\A2\AF\9C\A4r\C0\B7\FD\93&6?\F7\CC4\A5\E5\F1q\D81\15\04\C7#\C3\18\96\05\9A\07\12\80\E2\EB'\B2u\09\83,\1A\1BnZ\A0R;\D6\B3)\E3/\84S\D1\00\ED \FC\B1[j\CB\BE9JLX\CF\D0\EF\AA\FBCM3\85E\F9\02\7FP<\9F\A8Q\A3@\8F\92\9D8\F5\BC\B6\DA!\10\FF\F3\D2\CD\0C\13\EC_\97D\17\C4\A7~=d]\19s`\81O\DC\22*\90\88F\EE\B8\14\DE^\0B\DB\E02:\0AI\06$\\\C2\D3\ACb\91\95\E4y\E7\C87m\8D\D5N\A9lV\F4\EAez\AE\08\BAx%.\1C\A6\B4\C6\E8\DDt\1FK\BD\8B\8Ap>\B5fH\03\F6\0Ea5W\B9\86\C1\1D\9E\E1\F8\98\11i\D9\8E\94\9B\1E\87\E9\CEU(\DF\8C\A1\89\0D\BF\E6BhA\99-\0F\B0T\BB\16", align 16

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local zeroext i8 @aes_sbox_lookup(i8 noundef zeroext %x) local_unnamed_addr #0 {
entry:
  %idxprom = zext i8 %x to i64
  %arrayidx = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom
  %0 = load i8, ptr %arrayidx, align 1, !tbaa !5
  ret i8 %0
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @aes_mix_columns(ptr nocapture noundef %state) local_unnamed_addr #1 {
entry:
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %0 = shl nuw nsw i64 %indvars.iv, 2
  %add.ptr = getelementptr inbounds i8, ptr %state, i64 %0
  %1 = load i8, ptr %add.ptr, align 1, !tbaa !5
  %arrayidx1 = getelementptr inbounds i8, ptr %add.ptr, i64 1
  %2 = load i8, ptr %arrayidx1, align 1, !tbaa !5
  %arrayidx2 = getelementptr inbounds i8, ptr %add.ptr, i64 2
  %3 = load i8, ptr %arrayidx2, align 1, !tbaa !5
  %arrayidx3 = getelementptr inbounds i8, ptr %add.ptr, i64 3
  %4 = load i8, ptr %arrayidx3, align 1, !tbaa !5
  %xor79 = xor i8 %2, %1
  %5 = xor i8 %3, %xor79
  %conv9 = xor i8 %5, %4
  %shl.i = shl i8 %xor79, 1
  %isneg.i = icmp slt i8 %xor79, 0
  %mul.i = select i1 %isneg.i, i8 27, i8 0
  %6 = xor i8 %shl.i, %mul.i
  %7 = xor i8 %6, %1
  %xor1978 = xor i8 %7, %conv9
  store i8 %xor1978, ptr %add.ptr, align 1, !tbaa !5
  %xor24 = xor i8 %3, %2
  %shl.i88 = shl i8 %xor24, 1
  %isneg.i89 = icmp slt i8 %xor24, 0
  %mul.i90 = select i1 %isneg.i89, i8 27, i8 0
  %8 = xor i8 %shl.i88, %mul.i90
  %9 = xor i8 %8, %2
  %xor3181 = xor i8 %9, %conv9
  store i8 %xor3181, ptr %arrayidx1, align 1, !tbaa !5
  %xor3682 = xor i8 %4, %3
  %shl.i92 = shl i8 %xor3682, 1
  %isneg.i93 = icmp slt i8 %xor3682, 0
  %mul.i94 = select i1 %isneg.i93, i8 27, i8 0
  %10 = xor i8 %shl.i92, %mul.i94
  %11 = xor i8 %10, %4
  %xor4384 = xor i8 %11, %xor79
  store i8 %xor4384, ptr %arrayidx2, align 1, !tbaa !5
  %xor4885 = xor i8 %4, %1
  %shl.i96 = shl i8 %xor4885, 1
  %isneg.i97 = icmp slt i8 %xor4885, 0
  %mul.i98 = select i1 %isneg.i97, i8 27, i8 0
  %12 = xor i8 %shl.i96, %mul.i98
  %xor5587 = xor i8 %12, %5
  store i8 %xor5587, ptr %arrayidx3, align 1, !tbaa !5
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 4
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !8
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @aes_sub_bytes(ptr nocapture noundef %state) local_unnamed_addr #1 {
entry:
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i8, ptr %state, i64 %indvars.iv
  %0 = load i8, ptr %arrayidx, align 1, !tbaa !5
  %idxprom1 = zext i8 %0 to i64
  %arrayidx2 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1
  %1 = load i8, ptr %arrayidx2, align 1, !tbaa !5
  store i8 %1, ptr %arrayidx, align 1, !tbaa !5
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 16
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !11
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @aes_add_round_key(ptr nocapture noundef %state, ptr nocapture noundef readonly %rk) local_unnamed_addr #1 {
entry:
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i8, ptr %rk, i64 %indvars.iv
  %0 = load i8, ptr %arrayidx, align 1, !tbaa !5
  %arrayidx2 = getelementptr inbounds i8, ptr %state, i64 %indvars.iv
  %1 = load i8, ptr %arrayidx2, align 1, !tbaa !5
  %xor8 = xor i8 %1, %0
  store i8 %xor8, ptr %arrayidx2, align 1, !tbaa !5
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 16
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !12
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
!12 = distinct !{!12, !9, !10}
