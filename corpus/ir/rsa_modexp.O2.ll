; ModuleID = '/workspace/corpus/src/rsa_modexp.c'
source_filename = "/workspace/corpus/src/rsa_modexp.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind memory(none) uwtable
define dso_local i64 @rsa_modexp(i64 noundef %base, i64 noundef %exp, i64 noundef %mod) local_unnamed_addr #0 {
entry:
  %cmp.not13 = icmp eq i64 %exp, 0
  br i1 %cmp.not13, label %while.end, label %while.body

while.body:                                       ; preds = %entry, %if.end
  %mul2.pn = phi i64 [ %mul2, %if.end ], [ %base, %entry ]
  %result.015 = phi i64 [ %result.1, %if.end ], [ 1, %entry ]
  %exp.addr.014 = phi i64 [ %shr, %if.end ], [ %exp, %entry ]
  %base.addr.016 = urem i64 %mul2.pn, %mod
  %and = and i64 %exp.addr.014, 1
  %tobool.not = icmp eq i64 %and, 0
  br i1 %tobool.not, label %if.end, label %if.then

if.then:                                          ; preds = %while.body
  %mul = mul i64 %base.addr.016, %result.015
  %rem1 = urem i64 %mul, %mod
  br label %if.end

if.end:                                           ; preds = %if.then, %while.body
  %result.1 = phi i64 [ %rem1, %if.then ], [ %result.015, %while.body ]
  %shr = lshr i64 %exp.addr.014, 1
  %mul2 = mul i64 %base.addr.016, %base.addr.016
  %cmp.not = icmp ult i64 %exp.addr.014, 2
  br i1 %cmp.not, label %while.end, label %while.body, !llvm.loop !5

while.end:                                        ; preds = %if.end, %entry
  %result.0.lcssa = phi i64 [ 1, %entry ], [ %result.1, %if.end ]
  ret i64 %result.0.lcssa
}

attributes #0 = { nofree norecurse nosync nounwind memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
