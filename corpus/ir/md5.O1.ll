; ModuleID = '/workspace/corpus/src/md5.c'
source_filename = "/workspace/corpus/src/md5.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@md5_compress.s = internal unnamed_addr constant [64 x i32] [i32 7, i32 12, i32 17, i32 22, i32 7, i32 12, i32 17, i32 22, i32 7, i32 12, i32 17, i32 22, i32 7, i32 12, i32 17, i32 22, i32 5, i32 9, i32 14, i32 20, i32 5, i32 9, i32 14, i32 20, i32 5, i32 9, i32 14, i32 20, i32 5, i32 9, i32 14, i32 20, i32 4, i32 11, i32 16, i32 23, i32 4, i32 11, i32 16, i32 23, i32 4, i32 11, i32 16, i32 23, i32 4, i32 11, i32 16, i32 23, i32 6, i32 10, i32 15, i32 21, i32 6, i32 10, i32 15, i32 21, i32 6, i32 10, i32 15, i32 21, i32 6, i32 10, i32 15, i32 21], align 16
@T = internal unnamed_addr constant [64 x i32] [i32 -680876936, i32 -389564586, i32 606105819, i32 -1044525330, i32 -176418897, i32 1200080426, i32 -1473231341, i32 -45705983, i32 1770035416, i32 -1958414417, i32 -42063, i32 -1990404162, i32 1804603682, i32 -40341101, i32 -1502002290, i32 1236535329, i32 -165796510, i32 -1069501632, i32 643717713, i32 -373897302, i32 -701558691, i32 38016083, i32 -660478335, i32 -405537848, i32 568446438, i32 -1019803690, i32 -187363961, i32 1163531501, i32 -1444681467, i32 -51403784, i32 1735328473, i32 -1926607734, i32 -378558, i32 -2022574463, i32 1839030562, i32 -35309556, i32 -1530992060, i32 1272893353, i32 -155497632, i32 -1094730640, i32 681279174, i32 -358537222, i32 -722521979, i32 76029189, i32 -640364487, i32 -421815835, i32 530742520, i32 -995338651, i32 -198630844, i32 1126891415, i32 -1416354905, i32 -57434055, i32 1700485571, i32 -1894986606, i32 -1051523, i32 -2054922799, i32 1873313359, i32 -30611744, i32 -1560198380, i32 1309151649, i32 -145523070, i32 -1120210379, i32 718787259, i32 -343485551], align 16

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @md5_compress(ptr nocapture noundef %state, ptr nocapture noundef readonly %block) local_unnamed_addr #0 {
entry:
  %0 = load i32, ptr %state, align 4, !tbaa !5
  %arrayidx1 = getelementptr inbounds i32, ptr %state, i64 1
  %1 = load i32, ptr %arrayidx1, align 4, !tbaa !5
  %arrayidx2 = getelementptr inbounds i32, ptr %state, i64 2
  %2 = load i32, ptr %arrayidx2, align 4, !tbaa !5
  %arrayidx3 = getelementptr inbounds i32, ptr %state, i64 3
  %3 = load i32, ptr %arrayidx3, align 4, !tbaa !5
  br label %for.body

for.cond.cleanup:                                 ; preds = %if.end26
  %add37 = add i32 %d.082, %0
  store i32 %add37, ptr %state, align 4, !tbaa !5
  %add39 = add i32 %add35, %1
  store i32 %add39, ptr %arrayidx1, align 4, !tbaa !5
  %add41 = add i32 %b.080, %2
  store i32 %add41, ptr %arrayidx2, align 4, !tbaa !5
  %add43 = add i32 %c.081, %3
  store i32 %add43, ptr %arrayidx3, align 4, !tbaa !5
  ret void

for.body:                                         ; preds = %entry, %if.end26
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %if.end26 ]
  %a.084 = phi i32 [ %0, %entry ], [ %d.082, %if.end26 ]
  %d.082 = phi i32 [ %3, %entry ], [ %c.081, %if.end26 ]
  %c.081 = phi i32 [ %2, %entry ], [ %b.080, %if.end26 ]
  %b.080 = phi i32 [ %1, %entry ], [ %add35, %if.end26 ]
  %cmp4 = icmp ult i64 %indvars.iv, 16
  br i1 %cmp4, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %and = and i32 %c.081, %b.080
  %not = xor i32 %b.080, -1
  %and5 = and i32 %d.082, %not
  %or = or i32 %and5, %and
  br label %if.end26

if.else:                                          ; preds = %for.body
  %cmp6 = icmp ult i64 %indvars.iv, 32
  br i1 %cmp6, label %if.then7, label %if.else12

if.then7:                                         ; preds = %if.else
  %and8 = and i32 %d.082, %b.080
  %not9 = xor i32 %d.082, -1
  %and10 = and i32 %c.081, %not9
  %or11 = or i32 %and8, %and10
  %4 = mul nuw i64 %indvars.iv, 5
  %5 = add nuw nsw i64 %4, 1
  %rem = and i64 %5, 15
  br label %if.end26

if.else12:                                        ; preds = %if.else
  %cmp13 = icmp ult i64 %indvars.iv, 48
  br i1 %cmp13, label %if.then14, label %if.else19

if.then14:                                        ; preds = %if.else12
  %xor = xor i32 %c.081, %b.080
  %xor15 = xor i32 %xor, %d.082
  %6 = mul nuw i64 %indvars.iv, 3
  %7 = add nuw nsw i64 %6, 5
  %rem18 = and i64 %7, 15
  br label %if.end26

if.else19:                                        ; preds = %if.else12
  %not20 = xor i32 %d.082, -1
  %or21 = or i32 %b.080, %not20
  %xor22 = xor i32 %or21, %c.081
  %8 = mul i64 %indvars.iv, 7
  %rem24 = and i64 %8, 15
  br label %if.end26

if.end26:                                         ; preds = %if.then7, %if.else19, %if.then14, %if.then
  %f.0 = phi i32 [ %or, %if.then ], [ %or11, %if.then7 ], [ %xor15, %if.then14 ], [ %xor22, %if.else19 ]
  %g.0 = phi i64 [ %indvars.iv, %if.then ], [ %rem, %if.then7 ], [ %rem18, %if.then14 ], [ %rem24, %if.else19 ]
  %add27 = add i32 %f.0, %a.084
  %arrayidx28 = getelementptr inbounds [64 x i32], ptr @T, i64 0, i64 %indvars.iv
  %9 = load i32, ptr %arrayidx28, align 4, !tbaa !5
  %add29 = add i32 %add27, %9
  %arrayidx31 = getelementptr inbounds i32, ptr %block, i64 %g.0
  %10 = load i32, ptr %arrayidx31, align 4, !tbaa !5
  %add32 = add i32 %add29, %10
  %arrayidx34 = getelementptr inbounds [64 x i32], ptr @md5_compress.s, i64 0, i64 %indvars.iv
  %11 = load i32, ptr %arrayidx34, align 4, !tbaa !5
  %shl.i = shl i32 %add32, %11
  %sub.i = sub nsw i32 32, %11
  %shr.i = lshr i32 %add32, %sub.i
  %or.i = or i32 %shr.i, %shl.i
  %add35 = add i32 %or.i, %b.080
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 64
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !9
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
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = distinct !{!9, !10, !11}
!10 = !{!"llvm.loop.mustprogress"}
!11 = !{!"llvm.loop.unroll.disable"}
