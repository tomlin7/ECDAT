; ModuleID = '/workspace/corpus/src/aes.c'
source_filename = "/workspace/corpus/src/aes.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sbox = internal constant [256 x i8] c"c|w{\F2ko\C50\01g+\FE\D7\ABv\CA\82\C9}\FAYG\F0\AD\D4\A2\AF\9C\A4r\C0\B7\FD\93&6?\F7\CC4\A5\E5\F1q\D81\15\04\C7#\C3\18\96\05\9A\07\12\80\E2\EB'\B2u\09\83,\1A\1BnZ\A0R;\D6\B3)\E3/\84S\D1\00\ED \FC\B1[j\CB\BE9JLX\CF\D0\EF\AA\FBCM3\85E\F9\02\7FP<\9F\A8Q\A3@\8F\92\9D8\F5\BC\B6\DA!\10\FF\F3\D2\CD\0C\13\EC_\97D\17\C4\A7~=d]\19s`\81O\DC\22*\90\88F\EE\B8\14\DE^\0B\DB\E02:\0AI\06$\\\C2\D3\ACb\91\95\E4y\E7\C87m\8D\D5N\A9lV\F4\EAez\AE\08\BAx%.\1C\A6\B4\C6\E8\DDt\1FK\BD\8B\8Ap>\B5fH\03\F6\0Ea5W\B9\86\C1\1D\9E\E1\F8\98\11i\D9\8E\94\9B\1E\87\E9\CEU(\DF\8C\A1\89\0D\BF\E6BhA\99-\0F\B0T\BB\16", align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i8 @aes_sbox_lookup(i8 noundef zeroext %x) #0 {
entry:
  %x.addr = alloca i8, align 1
  store i8 %x, ptr %x.addr, align 1
  %0 = load i8, ptr %x.addr, align 1
  %idxprom = zext i8 %0 to i64
  %arrayidx = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom
  %1 = load i8, ptr %arrayidx, align 1
  ret i8 %1
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @aes_mix_columns(ptr noundef %state) #0 {
entry:
  %state.addr = alloca ptr, align 8
  %c = alloca i32, align 4
  %col = alloca ptr, align 8
  %a0 = alloca i8, align 1
  %a1 = alloca i8, align 1
  %a2 = alloca i8, align 1
  %a3 = alloca i8, align 1
  %t = alloca i8, align 1
  %u = alloca i8, align 1
  store ptr %state, ptr %state.addr, align 8
  store i32 0, ptr %c, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %c, align 4
  %cmp = icmp slt i32 %0, 4
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load ptr, ptr %state.addr, align 8
  %2 = load i32, ptr %c, align 4
  %mul = mul nsw i32 4, %2
  %idx.ext = sext i32 %mul to i64
  %add.ptr = getelementptr inbounds i8, ptr %1, i64 %idx.ext
  store ptr %add.ptr, ptr %col, align 8
  %3 = load ptr, ptr %col, align 8
  %arrayidx = getelementptr inbounds i8, ptr %3, i64 0
  %4 = load i8, ptr %arrayidx, align 1
  store i8 %4, ptr %a0, align 1
  %5 = load ptr, ptr %col, align 8
  %arrayidx1 = getelementptr inbounds i8, ptr %5, i64 1
  %6 = load i8, ptr %arrayidx1, align 1
  store i8 %6, ptr %a1, align 1
  %7 = load ptr, ptr %col, align 8
  %arrayidx2 = getelementptr inbounds i8, ptr %7, i64 2
  %8 = load i8, ptr %arrayidx2, align 1
  store i8 %8, ptr %a2, align 1
  %9 = load ptr, ptr %col, align 8
  %arrayidx3 = getelementptr inbounds i8, ptr %9, i64 3
  %10 = load i8, ptr %arrayidx3, align 1
  store i8 %10, ptr %a3, align 1
  %11 = load i8, ptr %a0, align 1
  %conv = zext i8 %11 to i32
  %12 = load i8, ptr %a1, align 1
  %conv4 = zext i8 %12 to i32
  %xor = xor i32 %conv, %conv4
  %13 = load i8, ptr %a2, align 1
  %conv5 = zext i8 %13 to i32
  %xor6 = xor i32 %xor, %conv5
  %14 = load i8, ptr %a3, align 1
  %conv7 = zext i8 %14 to i32
  %xor8 = xor i32 %xor6, %conv7
  %conv9 = trunc i32 %xor8 to i8
  store i8 %conv9, ptr %t, align 1
  %15 = load i8, ptr %a0, align 1
  store i8 %15, ptr %u, align 1
  %16 = load i8, ptr %t, align 1
  %conv10 = zext i8 %16 to i32
  %17 = load i8, ptr %a0, align 1
  %conv11 = zext i8 %17 to i32
  %18 = load i8, ptr %a1, align 1
  %conv12 = zext i8 %18 to i32
  %xor13 = xor i32 %conv11, %conv12
  %conv14 = trunc i32 %xor13 to i8
  %call = call zeroext i8 @xtime(i8 noundef zeroext %conv14)
  %conv15 = zext i8 %call to i32
  %xor16 = xor i32 %conv10, %conv15
  %19 = load ptr, ptr %col, align 8
  %arrayidx17 = getelementptr inbounds i8, ptr %19, i64 0
  %20 = load i8, ptr %arrayidx17, align 1
  %conv18 = zext i8 %20 to i32
  %xor19 = xor i32 %conv18, %xor16
  %conv20 = trunc i32 %xor19 to i8
  store i8 %conv20, ptr %arrayidx17, align 1
  %21 = load i8, ptr %t, align 1
  %conv21 = zext i8 %21 to i32
  %22 = load i8, ptr %a1, align 1
  %conv22 = zext i8 %22 to i32
  %23 = load i8, ptr %a2, align 1
  %conv23 = zext i8 %23 to i32
  %xor24 = xor i32 %conv22, %conv23
  %conv25 = trunc i32 %xor24 to i8
  %call26 = call zeroext i8 @xtime(i8 noundef zeroext %conv25)
  %conv27 = zext i8 %call26 to i32
  %xor28 = xor i32 %conv21, %conv27
  %24 = load ptr, ptr %col, align 8
  %arrayidx29 = getelementptr inbounds i8, ptr %24, i64 1
  %25 = load i8, ptr %arrayidx29, align 1
  %conv30 = zext i8 %25 to i32
  %xor31 = xor i32 %conv30, %xor28
  %conv32 = trunc i32 %xor31 to i8
  store i8 %conv32, ptr %arrayidx29, align 1
  %26 = load i8, ptr %t, align 1
  %conv33 = zext i8 %26 to i32
  %27 = load i8, ptr %a2, align 1
  %conv34 = zext i8 %27 to i32
  %28 = load i8, ptr %a3, align 1
  %conv35 = zext i8 %28 to i32
  %xor36 = xor i32 %conv34, %conv35
  %conv37 = trunc i32 %xor36 to i8
  %call38 = call zeroext i8 @xtime(i8 noundef zeroext %conv37)
  %conv39 = zext i8 %call38 to i32
  %xor40 = xor i32 %conv33, %conv39
  %29 = load ptr, ptr %col, align 8
  %arrayidx41 = getelementptr inbounds i8, ptr %29, i64 2
  %30 = load i8, ptr %arrayidx41, align 1
  %conv42 = zext i8 %30 to i32
  %xor43 = xor i32 %conv42, %xor40
  %conv44 = trunc i32 %xor43 to i8
  store i8 %conv44, ptr %arrayidx41, align 1
  %31 = load i8, ptr %t, align 1
  %conv45 = zext i8 %31 to i32
  %32 = load i8, ptr %a3, align 1
  %conv46 = zext i8 %32 to i32
  %33 = load i8, ptr %u, align 1
  %conv47 = zext i8 %33 to i32
  %xor48 = xor i32 %conv46, %conv47
  %conv49 = trunc i32 %xor48 to i8
  %call50 = call zeroext i8 @xtime(i8 noundef zeroext %conv49)
  %conv51 = zext i8 %call50 to i32
  %xor52 = xor i32 %conv45, %conv51
  %34 = load ptr, ptr %col, align 8
  %arrayidx53 = getelementptr inbounds i8, ptr %34, i64 3
  %35 = load i8, ptr %arrayidx53, align 1
  %conv54 = zext i8 %35 to i32
  %xor55 = xor i32 %conv54, %xor52
  %conv56 = trunc i32 %xor55 to i8
  store i8 %conv56, ptr %arrayidx53, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %36 = load i32, ptr %c, align 4
  %inc = add nsw i32 %36, 1
  store i32 %inc, ptr %c, align 4
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i8 @xtime(i8 noundef zeroext %x) #0 {
entry:
  %x.addr = alloca i8, align 1
  store i8 %x, ptr %x.addr, align 1
  %0 = load i8, ptr %x.addr, align 1
  %conv = zext i8 %0 to i32
  %shl = shl i32 %conv, 1
  %1 = load i8, ptr %x.addr, align 1
  %conv1 = zext i8 %1 to i32
  %shr = ashr i32 %conv1, 7
  %and = and i32 %shr, 1
  %mul = mul nsw i32 %and, 27
  %xor = xor i32 %shl, %mul
  %conv2 = trunc i32 %xor to i8
  ret i8 %conv2
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @aes_sub_bytes(ptr noundef %state) #0 {
entry:
  %state.addr = alloca ptr, align 8
  %i = alloca i32, align 4
  store ptr %state, ptr %state.addr, align 8
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load ptr, ptr %state.addr, align 8
  %2 = load i32, ptr %i, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds i8, ptr %1, i64 %idxprom
  %3 = load i8, ptr %arrayidx, align 1
  %idxprom1 = zext i8 %3 to i64
  %arrayidx2 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1
  %4 = load i8, ptr %arrayidx2, align 1
  %5 = load ptr, ptr %state.addr, align 8
  %6 = load i32, ptr %i, align 4
  %idxprom3 = sext i32 %6 to i64
  %arrayidx4 = getelementptr inbounds i8, ptr %5, i64 %idxprom3
  store i8 %4, ptr %arrayidx4, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %7 = load i32, ptr %i, align 4
  %inc = add nsw i32 %7, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !8

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @aes_add_round_key(ptr noundef %state, ptr noundef %rk) #0 {
entry:
  %state.addr = alloca ptr, align 8
  %rk.addr = alloca ptr, align 8
  %i = alloca i32, align 4
  store ptr %state, ptr %state.addr, align 8
  store ptr %rk, ptr %rk.addr, align 8
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load ptr, ptr %rk.addr, align 8
  %2 = load i32, ptr %i, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds i8, ptr %1, i64 %idxprom
  %3 = load i8, ptr %arrayidx, align 1
  %conv = zext i8 %3 to i32
  %4 = load ptr, ptr %state.addr, align 8
  %5 = load i32, ptr %i, align 4
  %idxprom1 = sext i32 %5 to i64
  %arrayidx2 = getelementptr inbounds i8, ptr %4, i64 %idxprom1
  %6 = load i8, ptr %arrayidx2, align 1
  %conv3 = zext i8 %6 to i32
  %xor = xor i32 %conv3, %conv
  %conv4 = trunc i32 %xor to i8
  store i8 %conv4, ptr %arrayidx2, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %7 = load i32, ptr %i, align 4
  %inc = add nsw i32 %7, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !9

for.end:                                          ; preds = %for.cond
  ret void
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
