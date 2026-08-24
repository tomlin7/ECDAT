; ModuleID = '/workspace/corpus/src/chacha20.c'
source_filename = "/workspace/corpus/src/chacha20.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@chacha20_sigma = dso_local local_unnamed_addr constant [4 x i32] [i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236], align 16

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @chacha20_block(ptr nocapture noundef writeonly %out, ptr nocapture noundef readonly %key, i32 noundef %counter, ptr nocapture noundef readonly %nonce) local_unnamed_addr #0 {
entry:
  %x = alloca [16 x i32], align 16
  %y = alloca [16 x i32], align 16
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %x) #4
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %x, ptr noundef nonnull align 16 dereferenceable(16) @chacha20_sigma, i64 16, i1 false)
  %scevgep = getelementptr inbounds i8, ptr %x, i64 16
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(32) %scevgep, ptr noundef nonnull align 4 dereferenceable(32) %key, i64 32, i1 false), !tbaa !5
  %arrayidx3 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 12
  store i32 %counter, ptr %arrayidx3, align 16, !tbaa !5
  %0 = load i32, ptr %nonce, align 4, !tbaa !5
  %arrayidx5 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 13
  store i32 %0, ptr %arrayidx5, align 4, !tbaa !5
  %arrayidx6 = getelementptr inbounds i32, ptr %nonce, i64 1
  %1 = load i32, ptr %arrayidx6, align 4, !tbaa !5
  %arrayidx7 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 14
  store i32 %1, ptr %arrayidx7, align 8, !tbaa !5
  %arrayidx8 = getelementptr inbounds i32, ptr %nonce, i64 2
  %2 = load i32, ptr %arrayidx8, align 4, !tbaa !5
  %arrayidx9 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 15
  store i32 %2, ptr %arrayidx9, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %y) #4
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(64) %y, ptr noundef nonnull align 16 dereferenceable(64) %x, i64 64, i1 false), !tbaa !5
  %arrayidx27 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 4
  %arrayidx28 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 8
  %arrayidx30 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 1
  %arrayidx31 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 5
  %arrayidx32 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 9
  %arrayidx34 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 2
  %arrayidx35 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 6
  %arrayidx36 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 10
  %arrayidx38 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 3
  %arrayidx39 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 7
  %arrayidx40 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 11
  %arrayidx27.promoted = load i32, ptr %arrayidx27, align 16, !tbaa !5
  %x.promoted = load i32, ptr %x, align 16, !tbaa !5
  %arrayidx3.promoted = load i32, ptr %arrayidx3, align 16, !tbaa !5
  %arrayidx28.promoted = load i32, ptr %arrayidx28, align 16, !tbaa !5
  %arrayidx31.promoted = load i32, ptr %arrayidx31, align 4, !tbaa !5
  %arrayidx30.promoted = load i32, ptr %arrayidx30, align 4, !tbaa !5
  %arrayidx5.promoted = load i32, ptr %arrayidx5, align 4, !tbaa !5
  %arrayidx32.promoted = load i32, ptr %arrayidx32, align 4, !tbaa !5
  %arrayidx35.promoted = load i32, ptr %arrayidx35, align 8, !tbaa !5
  %arrayidx34.promoted = load i32, ptr %arrayidx34, align 8, !tbaa !5
  %arrayidx7.promoted = load i32, ptr %arrayidx7, align 8, !tbaa !5
  %arrayidx36.promoted = load i32, ptr %arrayidx36, align 8, !tbaa !5
  %arrayidx39.promoted = load i32, ptr %arrayidx39, align 4, !tbaa !5
  %arrayidx38.promoted = load i32, ptr %arrayidx38, align 4, !tbaa !5
  %arrayidx9.promoted = load i32, ptr %arrayidx9, align 4, !tbaa !5
  %arrayidx40.promoted = load i32, ptr %arrayidx40, align 4, !tbaa !5
  br label %for.body25

for.cond62.preheader:                             ; preds = %for.body25
  store i32 %or.i38.i172, ptr %arrayidx27, align 16, !tbaa !5
  store i32 %add4.i131, ptr %x, align 16, !tbaa !5
  store i32 %or.i35.i145, ptr %arrayidx3, align 16, !tbaa !5
  store i32 %add7.i158, ptr %arrayidx28, align 16, !tbaa !5
  store i32 %or.i38.i136, ptr %arrayidx31, align 4, !tbaa !5
  store i32 %add4.i143, ptr %arrayidx30, align 4, !tbaa !5
  store i32 %or.i35.i157, ptr %arrayidx5, align 4, !tbaa !5
  store i32 %add7.i170, ptr %arrayidx32, align 4, !tbaa !5
  store i32 %or.i38.i148, ptr %arrayidx35, align 8, !tbaa !5
  store i32 %add4.i155, ptr %arrayidx34, align 8, !tbaa !5
  store i32 %or.i35.i169, ptr %arrayidx7, align 8, !tbaa !5
  store i32 %add7.i134, ptr %arrayidx36, align 8, !tbaa !5
  store i32 %or.i38.i160, ptr %arrayidx39, align 4, !tbaa !5
  store i32 %add4.i167, ptr %arrayidx38, align 4, !tbaa !5
  store i32 %or.i35.i133, ptr %arrayidx9, align 4, !tbaa !5
  store i32 %add7.i146, ptr %arrayidx40, align 4, !tbaa !5
  br label %for.body65

for.body25:                                       ; preds = %entry, %for.body25
  %r.0207 = phi i32 [ 0, %entry ], [ %inc59, %for.body25 ]
  %or.i38.i172175206 = phi i32 [ %arrayidx27.promoted, %entry ], [ %or.i38.i172, %for.body25 ]
  %add4.i131176205 = phi i32 [ %x.promoted, %entry ], [ %add4.i131, %for.body25 ]
  %or.i35.i145177204 = phi i32 [ %arrayidx3.promoted, %entry ], [ %or.i35.i145, %for.body25 ]
  %add7.i158178203 = phi i32 [ %arrayidx28.promoted, %entry ], [ %add7.i158, %for.body25 ]
  %or.i38.i136179202 = phi i32 [ %arrayidx31.promoted, %entry ], [ %or.i38.i136, %for.body25 ]
  %add4.i143180201 = phi i32 [ %arrayidx30.promoted, %entry ], [ %add4.i143, %for.body25 ]
  %or.i35.i157181200 = phi i32 [ %arrayidx5.promoted, %entry ], [ %or.i35.i157, %for.body25 ]
  %add7.i170182199 = phi i32 [ %arrayidx32.promoted, %entry ], [ %add7.i170, %for.body25 ]
  %or.i38.i148183198 = phi i32 [ %arrayidx35.promoted, %entry ], [ %or.i38.i148, %for.body25 ]
  %add4.i155184197 = phi i32 [ %arrayidx34.promoted, %entry ], [ %add4.i155, %for.body25 ]
  %or.i35.i169185196 = phi i32 [ %arrayidx7.promoted, %entry ], [ %or.i35.i169, %for.body25 ]
  %add7.i134186195 = phi i32 [ %arrayidx36.promoted, %entry ], [ %add7.i134, %for.body25 ]
  %or.i38.i160187194 = phi i32 [ %arrayidx39.promoted, %entry ], [ %or.i38.i160, %for.body25 ]
  %add4.i167188193 = phi i32 [ %arrayidx38.promoted, %entry ], [ %add4.i167, %for.body25 ]
  %or.i35.i133189192 = phi i32 [ %arrayidx9.promoted, %entry ], [ %or.i35.i133, %for.body25 ]
  %add7.i146190191 = phi i32 [ %arrayidx40.promoted, %entry ], [ %add7.i146, %for.body25 ]
  %add.i = add i32 %add4.i131176205, %or.i38.i172175206
  %xor.i = xor i32 %or.i35.i145177204, %add.i
  %or.i.i = tail call i32 @llvm.fshl.i32(i32 %xor.i, i32 %xor.i, i32 16)
  %add1.i = add i32 %add7.i158178203, %or.i.i
  %xor2.i = xor i32 %add1.i, %or.i38.i172175206
  %or.i32.i = tail call i32 @llvm.fshl.i32(i32 %xor2.i, i32 %xor2.i, i32 12)
  %add4.i = add i32 %or.i32.i, %add.i
  %xor5.i = xor i32 %add4.i, %or.i.i
  %or.i35.i = tail call i32 @llvm.fshl.i32(i32 %xor5.i, i32 %xor5.i, i32 8)
  %add7.i = add i32 %or.i35.i, %add1.i
  %xor8.i = xor i32 %add7.i, %or.i32.i
  %or.i38.i = tail call i32 @llvm.fshl.i32(i32 %xor8.i, i32 %xor8.i, i32 12)
  %add.i89 = add i32 %add4.i143180201, %or.i38.i136179202
  %xor.i90 = xor i32 %or.i35.i157181200, %add.i89
  %or.i.i91 = tail call i32 @llvm.fshl.i32(i32 %xor.i90, i32 %xor.i90, i32 16)
  %add1.i92 = add i32 %add7.i170182199, %or.i.i91
  %xor2.i93 = xor i32 %add1.i92, %or.i38.i136179202
  %or.i32.i94 = tail call i32 @llvm.fshl.i32(i32 %xor2.i93, i32 %xor2.i93, i32 12)
  %add4.i95 = add i32 %or.i32.i94, %add.i89
  %xor5.i96 = xor i32 %add4.i95, %or.i.i91
  %or.i35.i97 = tail call i32 @llvm.fshl.i32(i32 %xor5.i96, i32 %xor5.i96, i32 8)
  %add7.i98 = add i32 %or.i35.i97, %add1.i92
  %xor8.i99 = xor i32 %add7.i98, %or.i32.i94
  %or.i38.i100 = tail call i32 @llvm.fshl.i32(i32 %xor8.i99, i32 %xor8.i99, i32 12)
  %add.i101 = add i32 %add4.i155184197, %or.i38.i148183198
  %xor.i102 = xor i32 %or.i35.i169185196, %add.i101
  %or.i.i103 = tail call i32 @llvm.fshl.i32(i32 %xor.i102, i32 %xor.i102, i32 16)
  %add1.i104 = add i32 %add7.i134186195, %or.i.i103
  %xor2.i105 = xor i32 %add1.i104, %or.i38.i148183198
  %or.i32.i106 = tail call i32 @llvm.fshl.i32(i32 %xor2.i105, i32 %xor2.i105, i32 12)
  %add4.i107 = add i32 %or.i32.i106, %add.i101
  %xor5.i108 = xor i32 %add4.i107, %or.i.i103
  %or.i35.i109 = tail call i32 @llvm.fshl.i32(i32 %xor5.i108, i32 %xor5.i108, i32 8)
  %add7.i110 = add i32 %or.i35.i109, %add1.i104
  %xor8.i111 = xor i32 %add7.i110, %or.i32.i106
  %or.i38.i112 = tail call i32 @llvm.fshl.i32(i32 %xor8.i111, i32 %xor8.i111, i32 12)
  %add.i113 = add i32 %add4.i167188193, %or.i38.i160187194
  %xor.i114 = xor i32 %or.i35.i133189192, %add.i113
  %or.i.i115 = tail call i32 @llvm.fshl.i32(i32 %xor.i114, i32 %xor.i114, i32 16)
  %add1.i116 = add i32 %add7.i146190191, %or.i.i115
  %xor2.i117 = xor i32 %add1.i116, %or.i38.i160187194
  %or.i32.i118 = tail call i32 @llvm.fshl.i32(i32 %xor2.i117, i32 %xor2.i117, i32 12)
  %add4.i119 = add i32 %or.i32.i118, %add.i113
  %xor5.i120 = xor i32 %add4.i119, %or.i.i115
  %or.i35.i121 = tail call i32 @llvm.fshl.i32(i32 %xor5.i120, i32 %xor5.i120, i32 8)
  %add7.i122 = add i32 %or.i35.i121, %add1.i116
  %xor8.i123 = xor i32 %add7.i122, %or.i32.i118
  %or.i38.i124 = tail call i32 @llvm.fshl.i32(i32 %xor8.i123, i32 %xor8.i123, i32 12)
  %add.i125 = add i32 %or.i38.i100, %add4.i
  %xor.i126 = xor i32 %or.i35.i121, %add.i125
  %or.i.i127 = tail call i32 @llvm.fshl.i32(i32 %xor.i126, i32 %xor.i126, i32 16)
  %add1.i128 = add i32 %or.i.i127, %add7.i110
  %xor2.i129 = xor i32 %add1.i128, %or.i38.i100
  %or.i32.i130 = tail call i32 @llvm.fshl.i32(i32 %xor2.i129, i32 %xor2.i129, i32 12)
  %add4.i131 = add i32 %or.i32.i130, %add.i125
  %xor5.i132 = xor i32 %add4.i131, %or.i.i127
  %or.i35.i133 = tail call i32 @llvm.fshl.i32(i32 %xor5.i132, i32 %xor5.i132, i32 8)
  %add7.i134 = add i32 %or.i35.i133, %add1.i128
  %xor8.i135 = xor i32 %add7.i134, %or.i32.i130
  %or.i38.i136 = tail call i32 @llvm.fshl.i32(i32 %xor8.i135, i32 %xor8.i135, i32 12)
  %add.i137 = add i32 %or.i38.i112, %add4.i95
  %xor.i138 = xor i32 %add.i137, %or.i35.i
  %or.i.i139 = tail call i32 @llvm.fshl.i32(i32 %xor.i138, i32 %xor.i138, i32 16)
  %add1.i140 = add i32 %add7.i122, %or.i.i139
  %xor2.i141 = xor i32 %add1.i140, %or.i38.i112
  %or.i32.i142 = tail call i32 @llvm.fshl.i32(i32 %xor2.i141, i32 %xor2.i141, i32 12)
  %add4.i143 = add i32 %or.i32.i142, %add.i137
  %xor5.i144 = xor i32 %add4.i143, %or.i.i139
  %or.i35.i145 = tail call i32 @llvm.fshl.i32(i32 %xor5.i144, i32 %xor5.i144, i32 8)
  %add7.i146 = add i32 %or.i35.i145, %add1.i140
  %xor8.i147 = xor i32 %add7.i146, %or.i32.i142
  %or.i38.i148 = tail call i32 @llvm.fshl.i32(i32 %xor8.i147, i32 %xor8.i147, i32 12)
  %add.i149 = add i32 %or.i38.i124, %add4.i107
  %xor.i150 = xor i32 %add.i149, %or.i35.i97
  %or.i.i151 = tail call i32 @llvm.fshl.i32(i32 %xor.i150, i32 %xor.i150, i32 16)
  %add1.i152 = add i32 %or.i.i151, %add7.i
  %xor2.i153 = xor i32 %add1.i152, %or.i38.i124
  %or.i32.i154 = tail call i32 @llvm.fshl.i32(i32 %xor2.i153, i32 %xor2.i153, i32 12)
  %add4.i155 = add i32 %or.i32.i154, %add.i149
  %xor5.i156 = xor i32 %add4.i155, %or.i.i151
  %or.i35.i157 = tail call i32 @llvm.fshl.i32(i32 %xor5.i156, i32 %xor5.i156, i32 8)
  %add7.i158 = add i32 %or.i35.i157, %add1.i152
  %xor8.i159 = xor i32 %add7.i158, %or.i32.i154
  %or.i38.i160 = tail call i32 @llvm.fshl.i32(i32 %xor8.i159, i32 %xor8.i159, i32 12)
  %add.i161 = add i32 %add4.i119, %or.i38.i
  %xor.i162 = xor i32 %add.i161, %or.i35.i109
  %or.i.i163 = tail call i32 @llvm.fshl.i32(i32 %xor.i162, i32 %xor.i162, i32 16)
  %add1.i164 = add i32 %or.i.i163, %add7.i98
  %xor2.i165 = xor i32 %add1.i164, %or.i38.i
  %or.i32.i166 = tail call i32 @llvm.fshl.i32(i32 %xor2.i165, i32 %xor2.i165, i32 12)
  %add4.i167 = add i32 %or.i32.i166, %add.i161
  %xor5.i168 = xor i32 %add4.i167, %or.i.i163
  %or.i35.i169 = tail call i32 @llvm.fshl.i32(i32 %xor5.i168, i32 %xor5.i168, i32 8)
  %add7.i170 = add i32 %or.i35.i169, %add1.i164
  %xor8.i171 = xor i32 %add7.i170, %or.i32.i166
  %or.i38.i172 = tail call i32 @llvm.fshl.i32(i32 %xor8.i171, i32 %xor8.i171, i32 12)
  %inc59 = add nuw nsw i32 %r.0207, 1
  %exitcond.not = icmp eq i32 %inc59, 10
  br i1 %exitcond.not, label %for.cond62.preheader, label %for.body25, !llvm.loop !9

for.cond.cleanup64:                               ; preds = %for.body65
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %y) #4
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %x) #4
  ret void

for.body65:                                       ; preds = %for.cond62.preheader, %for.body65
  %indvars.iv = phi i64 [ 0, %for.cond62.preheader ], [ %indvars.iv.next, %for.body65 ]
  %arrayidx67 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 %indvars.iv
  %3 = load i32, ptr %arrayidx67, align 4, !tbaa !5
  %arrayidx69 = getelementptr inbounds [16 x i32], ptr %y, i64 0, i64 %indvars.iv
  %4 = load i32, ptr %arrayidx69, align 4, !tbaa !5
  %add70 = add i32 %4, %3
  %arrayidx72 = getelementptr inbounds i32, ptr %out, i64 %indvars.iv
  store i32 %add70, ptr %arrayidx72, align 4, !tbaa !5
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond213.not = icmp eq i64 %indvars.iv.next, 16
  br i1 %exitcond213.not, label %for.cond.cleanup64, label %for.body65, !llvm.loop !12
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.fshl.i32(i32, i32, i32) #3

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nounwind }

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
!12 = distinct !{!12, !10, !11}
