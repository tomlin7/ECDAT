; ModuleID = '/workspace/corpus/src/chacha20.c'
source_filename = "/workspace/corpus/src/chacha20.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @chacha20_block(ptr nocapture noundef writeonly %out, ptr nocapture noundef readonly %key, i32 noundef %counter, ptr nocapture noundef readonly %nonce) local_unnamed_addr #0 {
entry:
  %x = alloca [16 x i32], align 16
  %y = alloca [16 x i32], align 16
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %x) #4
  store i32 1634760805, ptr %x, align 16, !tbaa !5
  %arrayidx1 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 1
  store i32 857760878, ptr %arrayidx1, align 4, !tbaa !5
  %arrayidx2 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 2
  store i32 2036477234, ptr %arrayidx2, align 8, !tbaa !5
  %arrayidx3 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 3
  store i32 1797285236, ptr %arrayidx3, align 4, !tbaa !5
  %scevgep = getelementptr inbounds i8, ptr %x, i64 16
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(32) %scevgep, ptr noundef nonnull align 4 dereferenceable(32) %key, i64 32, i1 false), !tbaa !5
  %arrayidx7 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 12
  store i32 %counter, ptr %arrayidx7, align 16, !tbaa !5
  %0 = load i32, ptr %nonce, align 4, !tbaa !5
  %arrayidx9 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 13
  store i32 %0, ptr %arrayidx9, align 4, !tbaa !5
  %arrayidx10 = getelementptr inbounds i32, ptr %nonce, i64 1
  %1 = load i32, ptr %arrayidx10, align 4, !tbaa !5
  %arrayidx11 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 14
  store i32 %1, ptr %arrayidx11, align 8, !tbaa !5
  %arrayidx12 = getelementptr inbounds i32, ptr %nonce, i64 2
  %2 = load i32, ptr %arrayidx12, align 4, !tbaa !5
  %arrayidx13 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 15
  store i32 %2, ptr %arrayidx13, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %y) #4
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(64) %y, ptr noundef nonnull align 16 dereferenceable(64) %x, i64 64, i1 false), !tbaa !5
  %arrayidx31 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 4
  %arrayidx32 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 8
  %arrayidx35 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 5
  %arrayidx36 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 9
  %arrayidx39 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 6
  %arrayidx40 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 10
  %arrayidx43 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 7
  %arrayidx44 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 11
  %arrayidx31.promoted = load i32, ptr %arrayidx31, align 16, !tbaa !5
  %x.promoted = load i32, ptr %x, align 16, !tbaa !5
  %arrayidx7.promoted = load i32, ptr %arrayidx7, align 16, !tbaa !5
  %arrayidx32.promoted = load i32, ptr %arrayidx32, align 16, !tbaa !5
  %arrayidx35.promoted = load i32, ptr %arrayidx35, align 4, !tbaa !5
  %arrayidx1.promoted = load i32, ptr %arrayidx1, align 4, !tbaa !5
  %arrayidx9.promoted = load i32, ptr %arrayidx9, align 4, !tbaa !5
  %arrayidx36.promoted = load i32, ptr %arrayidx36, align 4, !tbaa !5
  %arrayidx39.promoted = load i32, ptr %arrayidx39, align 8, !tbaa !5
  %arrayidx2.promoted = load i32, ptr %arrayidx2, align 8, !tbaa !5
  %arrayidx11.promoted = load i32, ptr %arrayidx11, align 8, !tbaa !5
  %arrayidx40.promoted = load i32, ptr %arrayidx40, align 8, !tbaa !5
  %arrayidx43.promoted = load i32, ptr %arrayidx43, align 4, !tbaa !5
  %arrayidx3.promoted = load i32, ptr %arrayidx3, align 4, !tbaa !5
  %arrayidx13.promoted = load i32, ptr %arrayidx13, align 4, !tbaa !5
  %arrayidx44.promoted = load i32, ptr %arrayidx44, align 4, !tbaa !5
  br label %for.body29

for.cond66.preheader:                             ; preds = %for.body29
  store i32 %or.i38.i176, ptr %arrayidx31, align 16, !tbaa !5
  store i32 %add4.i135, ptr %x, align 16, !tbaa !5
  store i32 %or.i35.i149, ptr %arrayidx7, align 16, !tbaa !5
  store i32 %add7.i162, ptr %arrayidx32, align 16, !tbaa !5
  store i32 %or.i38.i140, ptr %arrayidx35, align 4, !tbaa !5
  store i32 %add4.i147, ptr %arrayidx1, align 4, !tbaa !5
  store i32 %or.i35.i161, ptr %arrayidx9, align 4, !tbaa !5
  store i32 %add7.i174, ptr %arrayidx36, align 4, !tbaa !5
  store i32 %or.i38.i152, ptr %arrayidx39, align 8, !tbaa !5
  store i32 %add4.i159, ptr %arrayidx2, align 8, !tbaa !5
  store i32 %or.i35.i173, ptr %arrayidx11, align 8, !tbaa !5
  store i32 %add7.i138, ptr %arrayidx40, align 8, !tbaa !5
  store i32 %or.i38.i164, ptr %arrayidx43, align 4, !tbaa !5
  store i32 %add4.i171, ptr %arrayidx3, align 4, !tbaa !5
  store i32 %or.i35.i137, ptr %arrayidx13, align 4, !tbaa !5
  store i32 %add7.i150, ptr %arrayidx44, align 4, !tbaa !5
  br label %for.body69

for.body29:                                       ; preds = %entry, %for.body29
  %r.0211 = phi i32 [ 0, %entry ], [ %inc63, %for.body29 ]
  %or.i38.i176179210 = phi i32 [ %arrayidx31.promoted, %entry ], [ %or.i38.i176, %for.body29 ]
  %add4.i135180209 = phi i32 [ %x.promoted, %entry ], [ %add4.i135, %for.body29 ]
  %or.i35.i149181208 = phi i32 [ %arrayidx7.promoted, %entry ], [ %or.i35.i149, %for.body29 ]
  %add7.i162182207 = phi i32 [ %arrayidx32.promoted, %entry ], [ %add7.i162, %for.body29 ]
  %or.i38.i140183206 = phi i32 [ %arrayidx35.promoted, %entry ], [ %or.i38.i140, %for.body29 ]
  %add4.i147184205 = phi i32 [ %arrayidx1.promoted, %entry ], [ %add4.i147, %for.body29 ]
  %or.i35.i161185204 = phi i32 [ %arrayidx9.promoted, %entry ], [ %or.i35.i161, %for.body29 ]
  %add7.i174186203 = phi i32 [ %arrayidx36.promoted, %entry ], [ %add7.i174, %for.body29 ]
  %or.i38.i152187202 = phi i32 [ %arrayidx39.promoted, %entry ], [ %or.i38.i152, %for.body29 ]
  %add4.i159188201 = phi i32 [ %arrayidx2.promoted, %entry ], [ %add4.i159, %for.body29 ]
  %or.i35.i173189200 = phi i32 [ %arrayidx11.promoted, %entry ], [ %or.i35.i173, %for.body29 ]
  %add7.i138190199 = phi i32 [ %arrayidx40.promoted, %entry ], [ %add7.i138, %for.body29 ]
  %or.i38.i164191198 = phi i32 [ %arrayidx43.promoted, %entry ], [ %or.i38.i164, %for.body29 ]
  %add4.i171192197 = phi i32 [ %arrayidx3.promoted, %entry ], [ %add4.i171, %for.body29 ]
  %or.i35.i137193196 = phi i32 [ %arrayidx13.promoted, %entry ], [ %or.i35.i137, %for.body29 ]
  %add7.i150194195 = phi i32 [ %arrayidx44.promoted, %entry ], [ %add7.i150, %for.body29 ]
  %add.i = add i32 %add4.i135180209, %or.i38.i176179210
  %xor.i = xor i32 %or.i35.i149181208, %add.i
  %or.i.i = tail call i32 @llvm.fshl.i32(i32 %xor.i, i32 %xor.i, i32 16)
  %add1.i = add i32 %add7.i162182207, %or.i.i
  %xor2.i = xor i32 %add1.i, %or.i38.i176179210
  %or.i32.i = tail call i32 @llvm.fshl.i32(i32 %xor2.i, i32 %xor2.i, i32 12)
  %add4.i = add i32 %or.i32.i, %add.i
  %xor5.i = xor i32 %add4.i, %or.i.i
  %or.i35.i = tail call i32 @llvm.fshl.i32(i32 %xor5.i, i32 %xor5.i, i32 8)
  %add7.i = add i32 %or.i35.i, %add1.i
  %xor8.i = xor i32 %add7.i, %or.i32.i
  %or.i38.i = tail call i32 @llvm.fshl.i32(i32 %xor8.i, i32 %xor8.i, i32 12)
  %add.i93 = add i32 %add4.i147184205, %or.i38.i140183206
  %xor.i94 = xor i32 %or.i35.i161185204, %add.i93
  %or.i.i95 = tail call i32 @llvm.fshl.i32(i32 %xor.i94, i32 %xor.i94, i32 16)
  %add1.i96 = add i32 %add7.i174186203, %or.i.i95
  %xor2.i97 = xor i32 %add1.i96, %or.i38.i140183206
  %or.i32.i98 = tail call i32 @llvm.fshl.i32(i32 %xor2.i97, i32 %xor2.i97, i32 12)
  %add4.i99 = add i32 %or.i32.i98, %add.i93
  %xor5.i100 = xor i32 %add4.i99, %or.i.i95
  %or.i35.i101 = tail call i32 @llvm.fshl.i32(i32 %xor5.i100, i32 %xor5.i100, i32 8)
  %add7.i102 = add i32 %or.i35.i101, %add1.i96
  %xor8.i103 = xor i32 %add7.i102, %or.i32.i98
  %or.i38.i104 = tail call i32 @llvm.fshl.i32(i32 %xor8.i103, i32 %xor8.i103, i32 12)
  %add.i105 = add i32 %add4.i159188201, %or.i38.i152187202
  %xor.i106 = xor i32 %or.i35.i173189200, %add.i105
  %or.i.i107 = tail call i32 @llvm.fshl.i32(i32 %xor.i106, i32 %xor.i106, i32 16)
  %add1.i108 = add i32 %add7.i138190199, %or.i.i107
  %xor2.i109 = xor i32 %add1.i108, %or.i38.i152187202
  %or.i32.i110 = tail call i32 @llvm.fshl.i32(i32 %xor2.i109, i32 %xor2.i109, i32 12)
  %add4.i111 = add i32 %or.i32.i110, %add.i105
  %xor5.i112 = xor i32 %add4.i111, %or.i.i107
  %or.i35.i113 = tail call i32 @llvm.fshl.i32(i32 %xor5.i112, i32 %xor5.i112, i32 8)
  %add7.i114 = add i32 %or.i35.i113, %add1.i108
  %xor8.i115 = xor i32 %add7.i114, %or.i32.i110
  %or.i38.i116 = tail call i32 @llvm.fshl.i32(i32 %xor8.i115, i32 %xor8.i115, i32 12)
  %add.i117 = add i32 %add4.i171192197, %or.i38.i164191198
  %xor.i118 = xor i32 %or.i35.i137193196, %add.i117
  %or.i.i119 = tail call i32 @llvm.fshl.i32(i32 %xor.i118, i32 %xor.i118, i32 16)
  %add1.i120 = add i32 %add7.i150194195, %or.i.i119
  %xor2.i121 = xor i32 %add1.i120, %or.i38.i164191198
  %or.i32.i122 = tail call i32 @llvm.fshl.i32(i32 %xor2.i121, i32 %xor2.i121, i32 12)
  %add4.i123 = add i32 %or.i32.i122, %add.i117
  %xor5.i124 = xor i32 %add4.i123, %or.i.i119
  %or.i35.i125 = tail call i32 @llvm.fshl.i32(i32 %xor5.i124, i32 %xor5.i124, i32 8)
  %add7.i126 = add i32 %or.i35.i125, %add1.i120
  %xor8.i127 = xor i32 %add7.i126, %or.i32.i122
  %or.i38.i128 = tail call i32 @llvm.fshl.i32(i32 %xor8.i127, i32 %xor8.i127, i32 12)
  %add.i129 = add i32 %or.i38.i104, %add4.i
  %xor.i130 = xor i32 %or.i35.i125, %add.i129
  %or.i.i131 = tail call i32 @llvm.fshl.i32(i32 %xor.i130, i32 %xor.i130, i32 16)
  %add1.i132 = add i32 %or.i.i131, %add7.i114
  %xor2.i133 = xor i32 %add1.i132, %or.i38.i104
  %or.i32.i134 = tail call i32 @llvm.fshl.i32(i32 %xor2.i133, i32 %xor2.i133, i32 12)
  %add4.i135 = add i32 %or.i32.i134, %add.i129
  %xor5.i136 = xor i32 %add4.i135, %or.i.i131
  %or.i35.i137 = tail call i32 @llvm.fshl.i32(i32 %xor5.i136, i32 %xor5.i136, i32 8)
  %add7.i138 = add i32 %or.i35.i137, %add1.i132
  %xor8.i139 = xor i32 %add7.i138, %or.i32.i134
  %or.i38.i140 = tail call i32 @llvm.fshl.i32(i32 %xor8.i139, i32 %xor8.i139, i32 12)
  %add.i141 = add i32 %or.i38.i116, %add4.i99
  %xor.i142 = xor i32 %add.i141, %or.i35.i
  %or.i.i143 = tail call i32 @llvm.fshl.i32(i32 %xor.i142, i32 %xor.i142, i32 16)
  %add1.i144 = add i32 %add7.i126, %or.i.i143
  %xor2.i145 = xor i32 %add1.i144, %or.i38.i116
  %or.i32.i146 = tail call i32 @llvm.fshl.i32(i32 %xor2.i145, i32 %xor2.i145, i32 12)
  %add4.i147 = add i32 %or.i32.i146, %add.i141
  %xor5.i148 = xor i32 %add4.i147, %or.i.i143
  %or.i35.i149 = tail call i32 @llvm.fshl.i32(i32 %xor5.i148, i32 %xor5.i148, i32 8)
  %add7.i150 = add i32 %or.i35.i149, %add1.i144
  %xor8.i151 = xor i32 %add7.i150, %or.i32.i146
  %or.i38.i152 = tail call i32 @llvm.fshl.i32(i32 %xor8.i151, i32 %xor8.i151, i32 12)
  %add.i153 = add i32 %or.i38.i128, %add4.i111
  %xor.i154 = xor i32 %add.i153, %or.i35.i101
  %or.i.i155 = tail call i32 @llvm.fshl.i32(i32 %xor.i154, i32 %xor.i154, i32 16)
  %add1.i156 = add i32 %or.i.i155, %add7.i
  %xor2.i157 = xor i32 %add1.i156, %or.i38.i128
  %or.i32.i158 = tail call i32 @llvm.fshl.i32(i32 %xor2.i157, i32 %xor2.i157, i32 12)
  %add4.i159 = add i32 %or.i32.i158, %add.i153
  %xor5.i160 = xor i32 %add4.i159, %or.i.i155
  %or.i35.i161 = tail call i32 @llvm.fshl.i32(i32 %xor5.i160, i32 %xor5.i160, i32 8)
  %add7.i162 = add i32 %or.i35.i161, %add1.i156
  %xor8.i163 = xor i32 %add7.i162, %or.i32.i158
  %or.i38.i164 = tail call i32 @llvm.fshl.i32(i32 %xor8.i163, i32 %xor8.i163, i32 12)
  %add.i165 = add i32 %add4.i123, %or.i38.i
  %xor.i166 = xor i32 %add.i165, %or.i35.i113
  %or.i.i167 = tail call i32 @llvm.fshl.i32(i32 %xor.i166, i32 %xor.i166, i32 16)
  %add1.i168 = add i32 %or.i.i167, %add7.i102
  %xor2.i169 = xor i32 %add1.i168, %or.i38.i
  %or.i32.i170 = tail call i32 @llvm.fshl.i32(i32 %xor2.i169, i32 %xor2.i169, i32 12)
  %add4.i171 = add i32 %or.i32.i170, %add.i165
  %xor5.i172 = xor i32 %add4.i171, %or.i.i167
  %or.i35.i173 = tail call i32 @llvm.fshl.i32(i32 %xor5.i172, i32 %xor5.i172, i32 8)
  %add7.i174 = add i32 %or.i35.i173, %add1.i168
  %xor8.i175 = xor i32 %add7.i174, %or.i32.i170
  %or.i38.i176 = tail call i32 @llvm.fshl.i32(i32 %xor8.i175, i32 %xor8.i175, i32 12)
  %inc63 = add nuw nsw i32 %r.0211, 1
  %exitcond.not = icmp eq i32 %inc63, 10
  br i1 %exitcond.not, label %for.cond66.preheader, label %for.body29, !llvm.loop !9

for.cond.cleanup68:                               ; preds = %for.body69
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %y) #4
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %x) #4
  ret void

for.body69:                                       ; preds = %for.cond66.preheader, %for.body69
  %indvars.iv = phi i64 [ 0, %for.cond66.preheader ], [ %indvars.iv.next, %for.body69 ]
  %arrayidx71 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 %indvars.iv
  %3 = load i32, ptr %arrayidx71, align 4, !tbaa !5
  %arrayidx73 = getelementptr inbounds [16 x i32], ptr %y, i64 0, i64 %indvars.iv
  %4 = load i32, ptr %arrayidx73, align 4, !tbaa !5
  %add74 = add i32 %4, %3
  %arrayidx76 = getelementptr inbounds i32, ptr %out, i64 %indvars.iv
  store i32 %add74, ptr %arrayidx76, align 4, !tbaa !5
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond217.not = icmp eq i64 %indvars.iv.next, 16
  br i1 %exitcond217.not, label %for.cond.cleanup68, label %for.body69, !llvm.loop !12
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.fshl.i32(i32, i32, i32) #2

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #3

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
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
