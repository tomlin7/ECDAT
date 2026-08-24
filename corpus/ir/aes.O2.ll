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

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable
define dso_local void @aes_mix_columns(ptr nocapture noundef %state) local_unnamed_addr #1 {
entry:
  %0 = load i8, ptr %state, align 1, !tbaa !5
  %arrayidx1 = getelementptr inbounds i8, ptr %state, i64 1
  %1 = load i8, ptr %arrayidx1, align 1, !tbaa !5
  %arrayidx2 = getelementptr inbounds i8, ptr %state, i64 2
  %2 = load i8, ptr %arrayidx2, align 1, !tbaa !5
  %arrayidx3 = getelementptr inbounds i8, ptr %state, i64 3
  %3 = load i8, ptr %arrayidx3, align 1, !tbaa !5
  %xor79 = xor i8 %1, %0
  %4 = xor i8 %2, %xor79
  %conv9 = xor i8 %4, %3
  %shl.i = shl i8 %xor79, 1
  %isneg.i = icmp slt i8 %xor79, 0
  %mul.i = select i1 %isneg.i, i8 27, i8 0
  %5 = xor i8 %shl.i, %mul.i
  %6 = xor i8 %5, %0
  %xor1978 = xor i8 %6, %conv9
  store i8 %xor1978, ptr %state, align 1, !tbaa !5
  %xor24 = xor i8 %2, %1
  %shl.i88 = shl i8 %xor24, 1
  %isneg.i89 = icmp slt i8 %xor24, 0
  %mul.i90 = select i1 %isneg.i89, i8 27, i8 0
  %7 = xor i8 %shl.i88, %mul.i90
  %8 = xor i8 %7, %1
  %xor3181 = xor i8 %8, %conv9
  store i8 %xor3181, ptr %arrayidx1, align 1, !tbaa !5
  %xor3682 = xor i8 %3, %2
  %shl.i92 = shl i8 %xor3682, 1
  %isneg.i93 = icmp slt i8 %xor3682, 0
  %mul.i94 = select i1 %isneg.i93, i8 27, i8 0
  %9 = xor i8 %shl.i92, %mul.i94
  %10 = xor i8 %9, %3
  %xor4384 = xor i8 %10, %xor79
  store i8 %xor4384, ptr %arrayidx2, align 1, !tbaa !5
  %xor4885 = xor i8 %3, %0
  %shl.i96 = shl i8 %xor4885, 1
  %isneg.i97 = icmp slt i8 %xor4885, 0
  %mul.i98 = select i1 %isneg.i97, i8 27, i8 0
  %11 = xor i8 %shl.i96, %mul.i98
  %xor5587 = xor i8 %11, %4
  store i8 %xor5587, ptr %arrayidx3, align 1, !tbaa !5
  %add.ptr.1 = getelementptr inbounds i8, ptr %state, i64 4
  %12 = load i8, ptr %add.ptr.1, align 1, !tbaa !5
  %arrayidx1.1 = getelementptr inbounds i8, ptr %state, i64 5
  %13 = load i8, ptr %arrayidx1.1, align 1, !tbaa !5
  %arrayidx2.1 = getelementptr inbounds i8, ptr %state, i64 6
  %14 = load i8, ptr %arrayidx2.1, align 1, !tbaa !5
  %arrayidx3.1 = getelementptr inbounds i8, ptr %state, i64 7
  %15 = load i8, ptr %arrayidx3.1, align 1, !tbaa !5
  %xor79.1 = xor i8 %13, %12
  %16 = xor i8 %14, %xor79.1
  %conv9.1 = xor i8 %16, %15
  %shl.i.1 = shl i8 %xor79.1, 1
  %isneg.i.1 = icmp slt i8 %xor79.1, 0
  %mul.i.1 = select i1 %isneg.i.1, i8 27, i8 0
  %17 = xor i8 %shl.i.1, %mul.i.1
  %18 = xor i8 %17, %12
  %xor1978.1 = xor i8 %18, %conv9.1
  store i8 %xor1978.1, ptr %add.ptr.1, align 1, !tbaa !5
  %xor24.1 = xor i8 %14, %13
  %shl.i88.1 = shl i8 %xor24.1, 1
  %isneg.i89.1 = icmp slt i8 %xor24.1, 0
  %mul.i90.1 = select i1 %isneg.i89.1, i8 27, i8 0
  %19 = xor i8 %shl.i88.1, %mul.i90.1
  %20 = xor i8 %19, %13
  %xor3181.1 = xor i8 %20, %conv9.1
  store i8 %xor3181.1, ptr %arrayidx1.1, align 1, !tbaa !5
  %xor3682.1 = xor i8 %15, %14
  %shl.i92.1 = shl i8 %xor3682.1, 1
  %isneg.i93.1 = icmp slt i8 %xor3682.1, 0
  %mul.i94.1 = select i1 %isneg.i93.1, i8 27, i8 0
  %21 = xor i8 %shl.i92.1, %mul.i94.1
  %22 = xor i8 %21, %15
  %xor4384.1 = xor i8 %22, %xor79.1
  store i8 %xor4384.1, ptr %arrayidx2.1, align 1, !tbaa !5
  %xor4885.1 = xor i8 %15, %12
  %shl.i96.1 = shl i8 %xor4885.1, 1
  %isneg.i97.1 = icmp slt i8 %xor4885.1, 0
  %mul.i98.1 = select i1 %isneg.i97.1, i8 27, i8 0
  %23 = xor i8 %shl.i96.1, %mul.i98.1
  %xor5587.1 = xor i8 %23, %16
  store i8 %xor5587.1, ptr %arrayidx3.1, align 1, !tbaa !5
  %add.ptr.2 = getelementptr inbounds i8, ptr %state, i64 8
  %24 = load i8, ptr %add.ptr.2, align 1, !tbaa !5
  %arrayidx1.2 = getelementptr inbounds i8, ptr %state, i64 9
  %25 = load i8, ptr %arrayidx1.2, align 1, !tbaa !5
  %arrayidx2.2 = getelementptr inbounds i8, ptr %state, i64 10
  %26 = load i8, ptr %arrayidx2.2, align 1, !tbaa !5
  %arrayidx3.2 = getelementptr inbounds i8, ptr %state, i64 11
  %27 = load i8, ptr %arrayidx3.2, align 1, !tbaa !5
  %xor79.2 = xor i8 %25, %24
  %28 = xor i8 %26, %xor79.2
  %conv9.2 = xor i8 %28, %27
  %shl.i.2 = shl i8 %xor79.2, 1
  %isneg.i.2 = icmp slt i8 %xor79.2, 0
  %mul.i.2 = select i1 %isneg.i.2, i8 27, i8 0
  %29 = xor i8 %shl.i.2, %mul.i.2
  %30 = xor i8 %29, %24
  %xor1978.2 = xor i8 %30, %conv9.2
  store i8 %xor1978.2, ptr %add.ptr.2, align 1, !tbaa !5
  %xor24.2 = xor i8 %26, %25
  %shl.i88.2 = shl i8 %xor24.2, 1
  %isneg.i89.2 = icmp slt i8 %xor24.2, 0
  %mul.i90.2 = select i1 %isneg.i89.2, i8 27, i8 0
  %31 = xor i8 %shl.i88.2, %mul.i90.2
  %32 = xor i8 %31, %25
  %xor3181.2 = xor i8 %32, %conv9.2
  store i8 %xor3181.2, ptr %arrayidx1.2, align 1, !tbaa !5
  %xor3682.2 = xor i8 %27, %26
  %shl.i92.2 = shl i8 %xor3682.2, 1
  %isneg.i93.2 = icmp slt i8 %xor3682.2, 0
  %mul.i94.2 = select i1 %isneg.i93.2, i8 27, i8 0
  %33 = xor i8 %shl.i92.2, %mul.i94.2
  %34 = xor i8 %33, %27
  %xor4384.2 = xor i8 %34, %xor79.2
  store i8 %xor4384.2, ptr %arrayidx2.2, align 1, !tbaa !5
  %xor4885.2 = xor i8 %27, %24
  %shl.i96.2 = shl i8 %xor4885.2, 1
  %isneg.i97.2 = icmp slt i8 %xor4885.2, 0
  %mul.i98.2 = select i1 %isneg.i97.2, i8 27, i8 0
  %35 = xor i8 %shl.i96.2, %mul.i98.2
  %xor5587.2 = xor i8 %35, %28
  store i8 %xor5587.2, ptr %arrayidx3.2, align 1, !tbaa !5
  %add.ptr.3 = getelementptr inbounds i8, ptr %state, i64 12
  %36 = load i8, ptr %add.ptr.3, align 1, !tbaa !5
  %arrayidx1.3 = getelementptr inbounds i8, ptr %state, i64 13
  %37 = load i8, ptr %arrayidx1.3, align 1, !tbaa !5
  %arrayidx2.3 = getelementptr inbounds i8, ptr %state, i64 14
  %38 = load i8, ptr %arrayidx2.3, align 1, !tbaa !5
  %arrayidx3.3 = getelementptr inbounds i8, ptr %state, i64 15
  %39 = load i8, ptr %arrayidx3.3, align 1, !tbaa !5
  %xor79.3 = xor i8 %37, %36
  %40 = xor i8 %38, %xor79.3
  %conv9.3 = xor i8 %40, %39
  %shl.i.3 = shl i8 %xor79.3, 1
  %isneg.i.3 = icmp slt i8 %xor79.3, 0
  %mul.i.3 = select i1 %isneg.i.3, i8 27, i8 0
  %41 = xor i8 %shl.i.3, %mul.i.3
  %42 = xor i8 %41, %36
  %xor1978.3 = xor i8 %42, %conv9.3
  store i8 %xor1978.3, ptr %add.ptr.3, align 1, !tbaa !5
  %xor24.3 = xor i8 %38, %37
  %shl.i88.3 = shl i8 %xor24.3, 1
  %isneg.i89.3 = icmp slt i8 %xor24.3, 0
  %mul.i90.3 = select i1 %isneg.i89.3, i8 27, i8 0
  %43 = xor i8 %shl.i88.3, %mul.i90.3
  %44 = xor i8 %43, %37
  %xor3181.3 = xor i8 %44, %conv9.3
  store i8 %xor3181.3, ptr %arrayidx1.3, align 1, !tbaa !5
  %xor3682.3 = xor i8 %39, %38
  %shl.i92.3 = shl i8 %xor3682.3, 1
  %isneg.i93.3 = icmp slt i8 %xor3682.3, 0
  %mul.i94.3 = select i1 %isneg.i93.3, i8 27, i8 0
  %45 = xor i8 %shl.i92.3, %mul.i94.3
  %46 = xor i8 %45, %39
  %xor4384.3 = xor i8 %46, %xor79.3
  store i8 %xor4384.3, ptr %arrayidx2.3, align 1, !tbaa !5
  %xor4885.3 = xor i8 %39, %36
  %shl.i96.3 = shl i8 %xor4885.3, 1
  %isneg.i97.3 = icmp slt i8 %xor4885.3, 0
  %mul.i98.3 = select i1 %isneg.i97.3, i8 27, i8 0
  %47 = xor i8 %shl.i96.3, %mul.i98.3
  %xor5587.3 = xor i8 %47, %40
  store i8 %xor5587.3, ptr %arrayidx3.3, align 1, !tbaa !5
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable
define dso_local void @aes_sub_bytes(ptr nocapture noundef %state) local_unnamed_addr #1 {
entry:
  %0 = load i8, ptr %state, align 1, !tbaa !5
  %idxprom1 = zext i8 %0 to i64
  %arrayidx2 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1
  %1 = load i8, ptr %arrayidx2, align 1, !tbaa !5
  store i8 %1, ptr %state, align 1, !tbaa !5
  %arrayidx.1 = getelementptr inbounds i8, ptr %state, i64 1
  %2 = load i8, ptr %arrayidx.1, align 1, !tbaa !5
  %idxprom1.1 = zext i8 %2 to i64
  %arrayidx2.1 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.1
  %3 = load i8, ptr %arrayidx2.1, align 1, !tbaa !5
  store i8 %3, ptr %arrayidx.1, align 1, !tbaa !5
  %arrayidx.2 = getelementptr inbounds i8, ptr %state, i64 2
  %4 = load i8, ptr %arrayidx.2, align 1, !tbaa !5
  %idxprom1.2 = zext i8 %4 to i64
  %arrayidx2.2 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.2
  %5 = load i8, ptr %arrayidx2.2, align 1, !tbaa !5
  store i8 %5, ptr %arrayidx.2, align 1, !tbaa !5
  %arrayidx.3 = getelementptr inbounds i8, ptr %state, i64 3
  %6 = load i8, ptr %arrayidx.3, align 1, !tbaa !5
  %idxprom1.3 = zext i8 %6 to i64
  %arrayidx2.3 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.3
  %7 = load i8, ptr %arrayidx2.3, align 1, !tbaa !5
  store i8 %7, ptr %arrayidx.3, align 1, !tbaa !5
  %arrayidx.4 = getelementptr inbounds i8, ptr %state, i64 4
  %8 = load i8, ptr %arrayidx.4, align 1, !tbaa !5
  %idxprom1.4 = zext i8 %8 to i64
  %arrayidx2.4 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.4
  %9 = load i8, ptr %arrayidx2.4, align 1, !tbaa !5
  store i8 %9, ptr %arrayidx.4, align 1, !tbaa !5
  %arrayidx.5 = getelementptr inbounds i8, ptr %state, i64 5
  %10 = load i8, ptr %arrayidx.5, align 1, !tbaa !5
  %idxprom1.5 = zext i8 %10 to i64
  %arrayidx2.5 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.5
  %11 = load i8, ptr %arrayidx2.5, align 1, !tbaa !5
  store i8 %11, ptr %arrayidx.5, align 1, !tbaa !5
  %arrayidx.6 = getelementptr inbounds i8, ptr %state, i64 6
  %12 = load i8, ptr %arrayidx.6, align 1, !tbaa !5
  %idxprom1.6 = zext i8 %12 to i64
  %arrayidx2.6 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.6
  %13 = load i8, ptr %arrayidx2.6, align 1, !tbaa !5
  store i8 %13, ptr %arrayidx.6, align 1, !tbaa !5
  %arrayidx.7 = getelementptr inbounds i8, ptr %state, i64 7
  %14 = load i8, ptr %arrayidx.7, align 1, !tbaa !5
  %idxprom1.7 = zext i8 %14 to i64
  %arrayidx2.7 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.7
  %15 = load i8, ptr %arrayidx2.7, align 1, !tbaa !5
  store i8 %15, ptr %arrayidx.7, align 1, !tbaa !5
  %arrayidx.8 = getelementptr inbounds i8, ptr %state, i64 8
  %16 = load i8, ptr %arrayidx.8, align 1, !tbaa !5
  %idxprom1.8 = zext i8 %16 to i64
  %arrayidx2.8 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.8
  %17 = load i8, ptr %arrayidx2.8, align 1, !tbaa !5
  store i8 %17, ptr %arrayidx.8, align 1, !tbaa !5
  %arrayidx.9 = getelementptr inbounds i8, ptr %state, i64 9
  %18 = load i8, ptr %arrayidx.9, align 1, !tbaa !5
  %idxprom1.9 = zext i8 %18 to i64
  %arrayidx2.9 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.9
  %19 = load i8, ptr %arrayidx2.9, align 1, !tbaa !5
  store i8 %19, ptr %arrayidx.9, align 1, !tbaa !5
  %arrayidx.10 = getelementptr inbounds i8, ptr %state, i64 10
  %20 = load i8, ptr %arrayidx.10, align 1, !tbaa !5
  %idxprom1.10 = zext i8 %20 to i64
  %arrayidx2.10 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.10
  %21 = load i8, ptr %arrayidx2.10, align 1, !tbaa !5
  store i8 %21, ptr %arrayidx.10, align 1, !tbaa !5
  %arrayidx.11 = getelementptr inbounds i8, ptr %state, i64 11
  %22 = load i8, ptr %arrayidx.11, align 1, !tbaa !5
  %idxprom1.11 = zext i8 %22 to i64
  %arrayidx2.11 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.11
  %23 = load i8, ptr %arrayidx2.11, align 1, !tbaa !5
  store i8 %23, ptr %arrayidx.11, align 1, !tbaa !5
  %arrayidx.12 = getelementptr inbounds i8, ptr %state, i64 12
  %24 = load i8, ptr %arrayidx.12, align 1, !tbaa !5
  %idxprom1.12 = zext i8 %24 to i64
  %arrayidx2.12 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.12
  %25 = load i8, ptr %arrayidx2.12, align 1, !tbaa !5
  store i8 %25, ptr %arrayidx.12, align 1, !tbaa !5
  %arrayidx.13 = getelementptr inbounds i8, ptr %state, i64 13
  %26 = load i8, ptr %arrayidx.13, align 1, !tbaa !5
  %idxprom1.13 = zext i8 %26 to i64
  %arrayidx2.13 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.13
  %27 = load i8, ptr %arrayidx2.13, align 1, !tbaa !5
  store i8 %27, ptr %arrayidx.13, align 1, !tbaa !5
  %arrayidx.14 = getelementptr inbounds i8, ptr %state, i64 14
  %28 = load i8, ptr %arrayidx.14, align 1, !tbaa !5
  %idxprom1.14 = zext i8 %28 to i64
  %arrayidx2.14 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.14
  %29 = load i8, ptr %arrayidx2.14, align 1, !tbaa !5
  store i8 %29, ptr %arrayidx.14, align 1, !tbaa !5
  %arrayidx.15 = getelementptr inbounds i8, ptr %state, i64 15
  %30 = load i8, ptr %arrayidx.15, align 1, !tbaa !5
  %idxprom1.15 = zext i8 %30 to i64
  %arrayidx2.15 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.15
  %31 = load i8, ptr %arrayidx2.15, align 1, !tbaa !5
  store i8 %31, ptr %arrayidx.15, align 1, !tbaa !5
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable
define dso_local void @aes_add_round_key(ptr nocapture noundef %state, ptr nocapture noundef readonly %rk) local_unnamed_addr #1 {
entry:
  %0 = load i8, ptr %rk, align 1, !tbaa !5
  %1 = load i8, ptr %state, align 1, !tbaa !5
  %xor8 = xor i8 %1, %0
  store i8 %xor8, ptr %state, align 1, !tbaa !5
  %arrayidx.1 = getelementptr inbounds i8, ptr %rk, i64 1
  %2 = load i8, ptr %arrayidx.1, align 1, !tbaa !5
  %arrayidx2.1 = getelementptr inbounds i8, ptr %state, i64 1
  %3 = load i8, ptr %arrayidx2.1, align 1, !tbaa !5
  %xor8.1 = xor i8 %3, %2
  store i8 %xor8.1, ptr %arrayidx2.1, align 1, !tbaa !5
  %arrayidx.2 = getelementptr inbounds i8, ptr %rk, i64 2
  %4 = load i8, ptr %arrayidx.2, align 1, !tbaa !5
  %arrayidx2.2 = getelementptr inbounds i8, ptr %state, i64 2
  %5 = load i8, ptr %arrayidx2.2, align 1, !tbaa !5
  %xor8.2 = xor i8 %5, %4
  store i8 %xor8.2, ptr %arrayidx2.2, align 1, !tbaa !5
  %arrayidx.3 = getelementptr inbounds i8, ptr %rk, i64 3
  %6 = load i8, ptr %arrayidx.3, align 1, !tbaa !5
  %arrayidx2.3 = getelementptr inbounds i8, ptr %state, i64 3
  %7 = load i8, ptr %arrayidx2.3, align 1, !tbaa !5
  %xor8.3 = xor i8 %7, %6
  store i8 %xor8.3, ptr %arrayidx2.3, align 1, !tbaa !5
  %arrayidx.4 = getelementptr inbounds i8, ptr %rk, i64 4
  %8 = load i8, ptr %arrayidx.4, align 1, !tbaa !5
  %arrayidx2.4 = getelementptr inbounds i8, ptr %state, i64 4
  %9 = load i8, ptr %arrayidx2.4, align 1, !tbaa !5
  %xor8.4 = xor i8 %9, %8
  store i8 %xor8.4, ptr %arrayidx2.4, align 1, !tbaa !5
  %arrayidx.5 = getelementptr inbounds i8, ptr %rk, i64 5
  %10 = load i8, ptr %arrayidx.5, align 1, !tbaa !5
  %arrayidx2.5 = getelementptr inbounds i8, ptr %state, i64 5
  %11 = load i8, ptr %arrayidx2.5, align 1, !tbaa !5
  %xor8.5 = xor i8 %11, %10
  store i8 %xor8.5, ptr %arrayidx2.5, align 1, !tbaa !5
  %arrayidx.6 = getelementptr inbounds i8, ptr %rk, i64 6
  %12 = load i8, ptr %arrayidx.6, align 1, !tbaa !5
  %arrayidx2.6 = getelementptr inbounds i8, ptr %state, i64 6
  %13 = load i8, ptr %arrayidx2.6, align 1, !tbaa !5
  %xor8.6 = xor i8 %13, %12
  store i8 %xor8.6, ptr %arrayidx2.6, align 1, !tbaa !5
  %arrayidx.7 = getelementptr inbounds i8, ptr %rk, i64 7
  %14 = load i8, ptr %arrayidx.7, align 1, !tbaa !5
  %arrayidx2.7 = getelementptr inbounds i8, ptr %state, i64 7
  %15 = load i8, ptr %arrayidx2.7, align 1, !tbaa !5
  %xor8.7 = xor i8 %15, %14
  store i8 %xor8.7, ptr %arrayidx2.7, align 1, !tbaa !5
  %arrayidx.8 = getelementptr inbounds i8, ptr %rk, i64 8
  %16 = load i8, ptr %arrayidx.8, align 1, !tbaa !5
  %arrayidx2.8 = getelementptr inbounds i8, ptr %state, i64 8
  %17 = load i8, ptr %arrayidx2.8, align 1, !tbaa !5
  %xor8.8 = xor i8 %17, %16
  store i8 %xor8.8, ptr %arrayidx2.8, align 1, !tbaa !5
  %arrayidx.9 = getelementptr inbounds i8, ptr %rk, i64 9
  %18 = load i8, ptr %arrayidx.9, align 1, !tbaa !5
  %arrayidx2.9 = getelementptr inbounds i8, ptr %state, i64 9
  %19 = load i8, ptr %arrayidx2.9, align 1, !tbaa !5
  %xor8.9 = xor i8 %19, %18
  store i8 %xor8.9, ptr %arrayidx2.9, align 1, !tbaa !5
  %arrayidx.10 = getelementptr inbounds i8, ptr %rk, i64 10
  %20 = load i8, ptr %arrayidx.10, align 1, !tbaa !5
  %arrayidx2.10 = getelementptr inbounds i8, ptr %state, i64 10
  %21 = load i8, ptr %arrayidx2.10, align 1, !tbaa !5
  %xor8.10 = xor i8 %21, %20
  store i8 %xor8.10, ptr %arrayidx2.10, align 1, !tbaa !5
  %arrayidx.11 = getelementptr inbounds i8, ptr %rk, i64 11
  %22 = load i8, ptr %arrayidx.11, align 1, !tbaa !5
  %arrayidx2.11 = getelementptr inbounds i8, ptr %state, i64 11
  %23 = load i8, ptr %arrayidx2.11, align 1, !tbaa !5
  %xor8.11 = xor i8 %23, %22
  store i8 %xor8.11, ptr %arrayidx2.11, align 1, !tbaa !5
  %arrayidx.12 = getelementptr inbounds i8, ptr %rk, i64 12
  %24 = load i8, ptr %arrayidx.12, align 1, !tbaa !5
  %arrayidx2.12 = getelementptr inbounds i8, ptr %state, i64 12
  %25 = load i8, ptr %arrayidx2.12, align 1, !tbaa !5
  %xor8.12 = xor i8 %25, %24
  store i8 %xor8.12, ptr %arrayidx2.12, align 1, !tbaa !5
  %arrayidx.13 = getelementptr inbounds i8, ptr %rk, i64 13
  %26 = load i8, ptr %arrayidx.13, align 1, !tbaa !5
  %arrayidx2.13 = getelementptr inbounds i8, ptr %state, i64 13
  %27 = load i8, ptr %arrayidx2.13, align 1, !tbaa !5
  %xor8.13 = xor i8 %27, %26
  store i8 %xor8.13, ptr %arrayidx2.13, align 1, !tbaa !5
  %arrayidx.14 = getelementptr inbounds i8, ptr %rk, i64 14
  %28 = load i8, ptr %arrayidx.14, align 1, !tbaa !5
  %arrayidx2.14 = getelementptr inbounds i8, ptr %state, i64 14
  %29 = load i8, ptr %arrayidx2.14, align 1, !tbaa !5
  %xor8.14 = xor i8 %29, %28
  store i8 %xor8.14, ptr %arrayidx2.14, align 1, !tbaa !5
  %arrayidx.15 = getelementptr inbounds i8, ptr %rk, i64 15
  %30 = load i8, ptr %arrayidx.15, align 1, !tbaa !5
  %arrayidx2.15 = getelementptr inbounds i8, ptr %state, i64 15
  %31 = load i8, ptr %arrayidx2.15, align 1, !tbaa !5
  %xor8.15 = xor i8 %31, %30
  store i8 %xor8.15, ptr %arrayidx2.15, align 1, !tbaa !5
  ret void
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
