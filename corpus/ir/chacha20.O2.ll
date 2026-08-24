; ModuleID = '/workspace/corpus/src/chacha20.c'
source_filename = "/workspace/corpus/src/chacha20.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @chacha20_block(ptr nocapture noundef writeonly %out, ptr nocapture noundef readonly %key, i32 noundef %counter, ptr nocapture noundef readonly %nonce) local_unnamed_addr #0 {
entry:
  %x.sroa.22.16.copyload = load i32, ptr %key, align 4, !tbaa !5
  %x.sroa.27.16.key.sroa_idx = getelementptr inbounds i8, ptr %key, i64 4
  %x.sroa.27.16.copyload = load i32, ptr %x.sroa.27.16.key.sroa_idx, align 4, !tbaa !5
  %x.sroa.31.16.key.sroa_idx = getelementptr inbounds i8, ptr %key, i64 8
  %x.sroa.31.16.copyload = load i32, ptr %x.sroa.31.16.key.sroa_idx, align 4, !tbaa !5
  %x.sroa.35.16.key.sroa_idx = getelementptr inbounds i8, ptr %key, i64 12
  %x.sroa.35.16.copyload = load i32, ptr %x.sroa.35.16.key.sroa_idx, align 4, !tbaa !5
  %x.sroa.39.16.key.sroa_idx = getelementptr inbounds i8, ptr %key, i64 16
  %x.sroa.39.16.copyload = load i32, ptr %x.sroa.39.16.key.sroa_idx, align 4, !tbaa !5
  %x.sroa.43.16.key.sroa_idx = getelementptr inbounds i8, ptr %key, i64 20
  %x.sroa.43.16.copyload = load i32, ptr %x.sroa.43.16.key.sroa_idx, align 4, !tbaa !5
  %x.sroa.47.16.key.sroa_idx = getelementptr inbounds i8, ptr %key, i64 24
  %x.sroa.47.16.copyload = load i32, ptr %x.sroa.47.16.key.sroa_idx, align 4, !tbaa !5
  %x.sroa.51.16.key.sroa_idx = getelementptr inbounds i8, ptr %key, i64 28
  %x.sroa.51.16.copyload = load i32, ptr %x.sroa.51.16.key.sroa_idx, align 4, !tbaa !5
  %0 = load i32, ptr %nonce, align 4, !tbaa !5
  %arrayidx10 = getelementptr inbounds i32, ptr %nonce, i64 1
  %1 = load i32, ptr %arrayidx10, align 4, !tbaa !5
  %arrayidx12 = getelementptr inbounds i32, ptr %nonce, i64 2
  %2 = load i32, ptr %arrayidx12, align 4, !tbaa !5
  br label %for.body29

for.cond66.preheader:                             ; preds = %for.body29
  %add74 = add i32 %add4.i135, 1634760805
  store i32 %add74, ptr %out, align 4, !tbaa !5
  %add74.1 = add i32 %add4.i147, 857760878
  %arrayidx76.1 = getelementptr inbounds i32, ptr %out, i64 1
  store i32 %add74.1, ptr %arrayidx76.1, align 4, !tbaa !5
  %add74.2 = add i32 %add4.i159, 2036477234
  %arrayidx76.2 = getelementptr inbounds i32, ptr %out, i64 2
  store i32 %add74.2, ptr %arrayidx76.2, align 4, !tbaa !5
  %add74.3 = add i32 %add4.i171, 1797285236
  %arrayidx76.3 = getelementptr inbounds i32, ptr %out, i64 3
  store i32 %add74.3, ptr %arrayidx76.3, align 4, !tbaa !5
  %add74.4 = add i32 %x.sroa.22.16.copyload, %or.i38.i176
  %arrayidx76.4 = getelementptr inbounds i32, ptr %out, i64 4
  store i32 %add74.4, ptr %arrayidx76.4, align 4, !tbaa !5
  %add74.5 = add i32 %x.sroa.27.16.copyload, %or.i38.i140
  %arrayidx76.5 = getelementptr inbounds i32, ptr %out, i64 5
  store i32 %add74.5, ptr %arrayidx76.5, align 4, !tbaa !5
  %add74.6 = add i32 %x.sroa.31.16.copyload, %or.i38.i152
  %arrayidx76.6 = getelementptr inbounds i32, ptr %out, i64 6
  store i32 %add74.6, ptr %arrayidx76.6, align 4, !tbaa !5
  %add74.7 = add i32 %x.sroa.35.16.copyload, %or.i38.i164
  %arrayidx76.7 = getelementptr inbounds i32, ptr %out, i64 7
  store i32 %add74.7, ptr %arrayidx76.7, align 4, !tbaa !5
  %add74.8 = add i32 %x.sroa.39.16.copyload, %add7.i162
  %arrayidx76.8 = getelementptr inbounds i32, ptr %out, i64 8
  store i32 %add74.8, ptr %arrayidx76.8, align 4, !tbaa !5
  %add74.9 = add i32 %x.sroa.43.16.copyload, %add7.i174
  %arrayidx76.9 = getelementptr inbounds i32, ptr %out, i64 9
  store i32 %add74.9, ptr %arrayidx76.9, align 4, !tbaa !5
  %add74.10 = add i32 %x.sroa.47.16.copyload, %add7.i138
  %arrayidx76.10 = getelementptr inbounds i32, ptr %out, i64 10
  store i32 %add74.10, ptr %arrayidx76.10, align 4, !tbaa !5
  %add74.11 = add i32 %x.sroa.51.16.copyload, %add7.i150
  %arrayidx76.11 = getelementptr inbounds i32, ptr %out, i64 11
  store i32 %add74.11, ptr %arrayidx76.11, align 4, !tbaa !5
  %add74.12 = add i32 %or.i35.i149, %counter
  %arrayidx76.12 = getelementptr inbounds i32, ptr %out, i64 12
  store i32 %add74.12, ptr %arrayidx76.12, align 4, !tbaa !5
  %add74.13 = add i32 %0, %or.i35.i161
  %arrayidx76.13 = getelementptr inbounds i32, ptr %out, i64 13
  store i32 %add74.13, ptr %arrayidx76.13, align 4, !tbaa !5
  %add74.14 = add i32 %1, %or.i35.i173
  %arrayidx76.14 = getelementptr inbounds i32, ptr %out, i64 14
  store i32 %add74.14, ptr %arrayidx76.14, align 4, !tbaa !5
  %add74.15 = add i32 %2, %or.i35.i137
  %arrayidx76.15 = getelementptr inbounds i32, ptr %out, i64 15
  store i32 %add74.15, ptr %arrayidx76.15, align 4, !tbaa !5
  ret void

for.body29:                                       ; preds = %entry, %for.body29
  %r.0211 = phi i32 [ 0, %entry ], [ %inc63, %for.body29 ]
  %or.i38.i176179210 = phi i32 [ %x.sroa.22.16.copyload, %entry ], [ %or.i38.i176, %for.body29 ]
  %add4.i135180209 = phi i32 [ 1634760805, %entry ], [ %add4.i135, %for.body29 ]
  %or.i35.i149181208 = phi i32 [ %counter, %entry ], [ %or.i35.i149, %for.body29 ]
  %add7.i162182207 = phi i32 [ %x.sroa.39.16.copyload, %entry ], [ %add7.i162, %for.body29 ]
  %or.i38.i140183206 = phi i32 [ %x.sroa.27.16.copyload, %entry ], [ %or.i38.i140, %for.body29 ]
  %add4.i147184205 = phi i32 [ 857760878, %entry ], [ %add4.i147, %for.body29 ]
  %or.i35.i161185204 = phi i32 [ %0, %entry ], [ %or.i35.i161, %for.body29 ]
  %add7.i174186203 = phi i32 [ %x.sroa.43.16.copyload, %entry ], [ %add7.i174, %for.body29 ]
  %or.i38.i152187202 = phi i32 [ %x.sroa.31.16.copyload, %entry ], [ %or.i38.i152, %for.body29 ]
  %add4.i159188201 = phi i32 [ 2036477234, %entry ], [ %add4.i159, %for.body29 ]
  %or.i35.i173189200 = phi i32 [ %1, %entry ], [ %or.i35.i173, %for.body29 ]
  %add7.i138190199 = phi i32 [ %x.sroa.47.16.copyload, %entry ], [ %add7.i138, %for.body29 ]
  %or.i38.i164191198 = phi i32 [ %x.sroa.35.16.copyload, %entry ], [ %or.i38.i164, %for.body29 ]
  %add4.i171192197 = phi i32 [ 1797285236, %entry ], [ %add4.i171, %for.body29 ]
  %or.i35.i137193196 = phi i32 [ %2, %entry ], [ %or.i35.i137, %for.body29 ]
  %add7.i150194195 = phi i32 [ %x.sroa.51.16.copyload, %entry ], [ %add7.i150, %for.body29 ]
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
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.fshl.i32(i32, i32, i32) #1

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

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
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.mustprogress"}
