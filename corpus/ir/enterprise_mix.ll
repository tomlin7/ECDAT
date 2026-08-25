; ModuleID = '/workspace/corpus/src/enterprise_mix.c'
source_filename = "/workspace/corpus/src/enterprise_mix.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sbox = internal constant [256 x i8] c"c|w{\F2ko\C50\01g+\FE\D7\ABv\CA\82\C9}\FAYG\F0\AD\D4\A2\AF\9C\A4r\C0\B7\FD\93&6?\F7\CC4\A5\E5\F1q\D81\15\04\C7#\C3\18\96\05\9A\07\12\80\E2\EB'\B2u\09\83,\1A\1BnZ\A0R;\D6\B3)\E3/\84S\D1\00\ED \FC\B1[j\CB\BE9JLX\CF\D0\EF\AA\FBCM3\85E\F9\02\7FP<\9F\A8Q\A3@\8F\92\9D8\F5\BC\B6\DA!\10\FF\F3\D2\CD\0C\13\EC_\97D\17\C4\A7~=d]\19s`\81O\DC\22*\90\88F\EE\B8\14\DE^\0B\DB\E02:\0AI\06$\\\C2\D3\ACb\91\95\E4y\E7\C87m\8D\D5N\A9lV\F4\EAez\AE\08\BAx%.\1C\A6\B4\C6\E8\DDt\1FK\BD\8B\8Ap>\B5fH\03\F6\0Ea5W\B9\86\C1\1D\9E\E1\F8\98\11i\D9\8E\94\9B\1E\87\E9\CEU(\DF\8C\A1\89\0D\BF\E6BhA\99-\0F\B0T\BB\16", align 16
@K = internal constant [64 x i32] [i32 1116352408, i32 1899447441, i32 -1245643825, i32 -373957723, i32 961987163, i32 1508970993, i32 -1841331548, i32 -1424204075, i32 -670586216, i32 310598401, i32 607225278, i32 1426881987, i32 1925078388, i32 -2132889090, i32 -1680079193, i32 -1046744716, i32 -459576895, i32 -272742522, i32 264347078, i32 604807628, i32 770255983, i32 1249150122, i32 1555081692, i32 1996064986, i32 -1740746414, i32 -1473132947, i32 -1341970488, i32 -1084653625, i32 -958395405, i32 -710438585, i32 113926993, i32 338241895, i32 666307205, i32 773529912, i32 1294757372, i32 1396182291, i32 1695183700, i32 1986661051, i32 -2117940946, i32 -1838011259, i32 -1564481375, i32 -1474664885, i32 -1035236496, i32 -949202525, i32 -778901479, i32 -694614492, i32 -200395387, i32 275423344, i32 430227734, i32 506948616, i32 659060556, i32 883997877, i32 958139571, i32 1322822218, i32 1537002063, i32 1747873779, i32 1955562222, i32 2024104815, i32 -2067236844, i32 -1933114872, i32 -1866530822, i32 -1538233109, i32 -1090935817, i32 -965641998], align 16
@chacha20_sigma = dso_local constant [4 x i32] [i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236], align 16
@md5_compress.s = internal constant [64 x i32] [i32 7, i32 12, i32 17, i32 22, i32 7, i32 12, i32 17, i32 22, i32 7, i32 12, i32 17, i32 22, i32 7, i32 12, i32 17, i32 22, i32 5, i32 9, i32 14, i32 20, i32 5, i32 9, i32 14, i32 20, i32 5, i32 9, i32 14, i32 20, i32 5, i32 9, i32 14, i32 20, i32 4, i32 11, i32 16, i32 23, i32 4, i32 11, i32 16, i32 23, i32 4, i32 11, i32 16, i32 23, i32 4, i32 11, i32 16, i32 23, i32 6, i32 10, i32 15, i32 21, i32 6, i32 10, i32 15, i32 21, i32 6, i32 10, i32 15, i32 21, i32 6, i32 10, i32 15, i32 21], align 16
@T = internal constant [64 x i32] [i32 -680876936, i32 -389564586, i32 606105819, i32 -1044525330, i32 -176418897, i32 1200080426, i32 -1473231341, i32 -45705983, i32 1770035416, i32 -1958414417, i32 -42063, i32 -1990404162, i32 1804603682, i32 -40341101, i32 -1502002290, i32 1236535329, i32 -165796510, i32 -1069501632, i32 643717713, i32 -373897302, i32 -701558691, i32 38016083, i32 -660478335, i32 -405537848, i32 568446438, i32 -1019803690, i32 -187363961, i32 1163531501, i32 -1444681467, i32 -51403784, i32 1735328473, i32 -1926607734, i32 -378558, i32 -2022574463, i32 1839030562, i32 -35309556, i32 -1530992060, i32 1272893353, i32 -155497632, i32 -1094730640, i32 681279174, i32 -358537222, i32 -722521979, i32 76029189, i32 -640364487, i32 -421815835, i32 530742520, i32 -995338651, i32 -198630844, i32 1126891415, i32 -1416354905, i32 -57434055, i32 1700485571, i32 -1894986606, i32 -1051523, i32 -2054922799, i32 1873313359, i32 -30611744, i32 -1560198380, i32 1309151649, i32 -145523070, i32 -1120210379, i32 718787259, i32 -343485551], align 16

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

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @sha256_compress(ptr noundef %state, ptr noundef %block) #0 {
entry:
  %state.addr = alloca ptr, align 8
  %block.addr = alloca ptr, align 8
  %w = alloca [64 x i32], align 16
  %i = alloca i32, align 4
  %i21 = alloca i32, align 4
  %s0 = alloca i32, align 4
  %s1 = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %e = alloca i32, align 4
  %f = alloca i32, align 4
  %g = alloca i32, align 4
  %h = alloca i32, align 4
  %i72 = alloca i32, align 4
  %S1 = alloca i32, align 4
  %ch = alloca i32, align 4
  %temp1 = alloca i32, align 4
  %S0 = alloca i32, align 4
  %maj = alloca i32, align 4
  %temp2 = alloca i32, align 4
  store ptr %state, ptr %state.addr, align 8
  store ptr %block, ptr %block.addr, align 8
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load ptr, ptr %block.addr, align 8
  %2 = load i32, ptr %i, align 4
  %mul = mul nsw i32 %2, 4
  %idxprom = sext i32 %mul to i64
  %arrayidx = getelementptr inbounds i8, ptr %1, i64 %idxprom
  %3 = load i8, ptr %arrayidx, align 1
  %conv = zext i8 %3 to i32
  %shl = shl i32 %conv, 24
  %4 = load ptr, ptr %block.addr, align 8
  %5 = load i32, ptr %i, align 4
  %mul1 = mul nsw i32 %5, 4
  %add = add nsw i32 %mul1, 1
  %idxprom2 = sext i32 %add to i64
  %arrayidx3 = getelementptr inbounds i8, ptr %4, i64 %idxprom2
  %6 = load i8, ptr %arrayidx3, align 1
  %conv4 = zext i8 %6 to i32
  %shl5 = shl i32 %conv4, 16
  %or = or i32 %shl, %shl5
  %7 = load ptr, ptr %block.addr, align 8
  %8 = load i32, ptr %i, align 4
  %mul6 = mul nsw i32 %8, 4
  %add7 = add nsw i32 %mul6, 2
  %idxprom8 = sext i32 %add7 to i64
  %arrayidx9 = getelementptr inbounds i8, ptr %7, i64 %idxprom8
  %9 = load i8, ptr %arrayidx9, align 1
  %conv10 = zext i8 %9 to i32
  %shl11 = shl i32 %conv10, 8
  %or12 = or i32 %or, %shl11
  %10 = load ptr, ptr %block.addr, align 8
  %11 = load i32, ptr %i, align 4
  %mul13 = mul nsw i32 %11, 4
  %add14 = add nsw i32 %mul13, 3
  %idxprom15 = sext i32 %add14 to i64
  %arrayidx16 = getelementptr inbounds i8, ptr %10, i64 %idxprom15
  %12 = load i8, ptr %arrayidx16, align 1
  %conv17 = zext i8 %12 to i32
  %or18 = or i32 %or12, %conv17
  %13 = load i32, ptr %i, align 4
  %idxprom19 = sext i32 %13 to i64
  %arrayidx20 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %idxprom19
  store i32 %or18, ptr %arrayidx20, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %14 = load i32, ptr %i, align 4
  %inc = add nsw i32 %14, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !10

for.end:                                          ; preds = %for.cond
  store i32 16, ptr %i21, align 4
  br label %for.cond22

for.cond22:                                       ; preds = %for.inc61, %for.end
  %15 = load i32, ptr %i21, align 4
  %cmp23 = icmp slt i32 %15, 64
  br i1 %cmp23, label %for.body25, label %for.end63

for.body25:                                       ; preds = %for.cond22
  %16 = load i32, ptr %i21, align 4
  %sub = sub nsw i32 %16, 15
  %idxprom26 = sext i32 %sub to i64
  %arrayidx27 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %idxprom26
  %17 = load i32, ptr %arrayidx27, align 4
  %call = call i32 @rotr(i32 noundef %17, i32 noundef 7)
  %18 = load i32, ptr %i21, align 4
  %sub28 = sub nsw i32 %18, 15
  %idxprom29 = sext i32 %sub28 to i64
  %arrayidx30 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %idxprom29
  %19 = load i32, ptr %arrayidx30, align 4
  %call31 = call i32 @rotr(i32 noundef %19, i32 noundef 18)
  %xor = xor i32 %call, %call31
  %20 = load i32, ptr %i21, align 4
  %sub32 = sub nsw i32 %20, 15
  %idxprom33 = sext i32 %sub32 to i64
  %arrayidx34 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %idxprom33
  %21 = load i32, ptr %arrayidx34, align 4
  %shr = lshr i32 %21, 3
  %xor35 = xor i32 %xor, %shr
  store i32 %xor35, ptr %s0, align 4
  %22 = load i32, ptr %i21, align 4
  %sub36 = sub nsw i32 %22, 2
  %idxprom37 = sext i32 %sub36 to i64
  %arrayidx38 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %idxprom37
  %23 = load i32, ptr %arrayidx38, align 4
  %call39 = call i32 @rotr(i32 noundef %23, i32 noundef 17)
  %24 = load i32, ptr %i21, align 4
  %sub40 = sub nsw i32 %24, 2
  %idxprom41 = sext i32 %sub40 to i64
  %arrayidx42 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %idxprom41
  %25 = load i32, ptr %arrayidx42, align 4
  %call43 = call i32 @rotr(i32 noundef %25, i32 noundef 19)
  %xor44 = xor i32 %call39, %call43
  %26 = load i32, ptr %i21, align 4
  %sub45 = sub nsw i32 %26, 2
  %idxprom46 = sext i32 %sub45 to i64
  %arrayidx47 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %idxprom46
  %27 = load i32, ptr %arrayidx47, align 4
  %shr48 = lshr i32 %27, 10
  %xor49 = xor i32 %xor44, %shr48
  store i32 %xor49, ptr %s1, align 4
  %28 = load i32, ptr %i21, align 4
  %sub50 = sub nsw i32 %28, 16
  %idxprom51 = sext i32 %sub50 to i64
  %arrayidx52 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %idxprom51
  %29 = load i32, ptr %arrayidx52, align 4
  %30 = load i32, ptr %s0, align 4
  %add53 = add i32 %29, %30
  %31 = load i32, ptr %i21, align 4
  %sub54 = sub nsw i32 %31, 7
  %idxprom55 = sext i32 %sub54 to i64
  %arrayidx56 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %idxprom55
  %32 = load i32, ptr %arrayidx56, align 4
  %add57 = add i32 %add53, %32
  %33 = load i32, ptr %s1, align 4
  %add58 = add i32 %add57, %33
  %34 = load i32, ptr %i21, align 4
  %idxprom59 = sext i32 %34 to i64
  %arrayidx60 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %idxprom59
  store i32 %add58, ptr %arrayidx60, align 4
  br label %for.inc61

for.inc61:                                        ; preds = %for.body25
  %35 = load i32, ptr %i21, align 4
  %inc62 = add nsw i32 %35, 1
  store i32 %inc62, ptr %i21, align 4
  br label %for.cond22, !llvm.loop !11

for.end63:                                        ; preds = %for.cond22
  %36 = load ptr, ptr %state.addr, align 8
  %arrayidx64 = getelementptr inbounds i32, ptr %36, i64 0
  %37 = load i32, ptr %arrayidx64, align 4
  store i32 %37, ptr %a, align 4
  %38 = load ptr, ptr %state.addr, align 8
  %arrayidx65 = getelementptr inbounds i32, ptr %38, i64 1
  %39 = load i32, ptr %arrayidx65, align 4
  store i32 %39, ptr %b, align 4
  %40 = load ptr, ptr %state.addr, align 8
  %arrayidx66 = getelementptr inbounds i32, ptr %40, i64 2
  %41 = load i32, ptr %arrayidx66, align 4
  store i32 %41, ptr %c, align 4
  %42 = load ptr, ptr %state.addr, align 8
  %arrayidx67 = getelementptr inbounds i32, ptr %42, i64 3
  %43 = load i32, ptr %arrayidx67, align 4
  store i32 %43, ptr %d, align 4
  %44 = load ptr, ptr %state.addr, align 8
  %arrayidx68 = getelementptr inbounds i32, ptr %44, i64 4
  %45 = load i32, ptr %arrayidx68, align 4
  store i32 %45, ptr %e, align 4
  %46 = load ptr, ptr %state.addr, align 8
  %arrayidx69 = getelementptr inbounds i32, ptr %46, i64 5
  %47 = load i32, ptr %arrayidx69, align 4
  store i32 %47, ptr %f, align 4
  %48 = load ptr, ptr %state.addr, align 8
  %arrayidx70 = getelementptr inbounds i32, ptr %48, i64 6
  %49 = load i32, ptr %arrayidx70, align 4
  store i32 %49, ptr %g, align 4
  %50 = load ptr, ptr %state.addr, align 8
  %arrayidx71 = getelementptr inbounds i32, ptr %50, i64 7
  %51 = load i32, ptr %arrayidx71, align 4
  store i32 %51, ptr %h, align 4
  store i32 0, ptr %i72, align 4
  br label %for.cond73

for.cond73:                                       ; preds = %for.inc105, %for.end63
  %52 = load i32, ptr %i72, align 4
  %cmp74 = icmp slt i32 %52, 64
  br i1 %cmp74, label %for.body76, label %for.end107

for.body76:                                       ; preds = %for.cond73
  %53 = load i32, ptr %e, align 4
  %call77 = call i32 @rotr(i32 noundef %53, i32 noundef 6)
  %54 = load i32, ptr %e, align 4
  %call78 = call i32 @rotr(i32 noundef %54, i32 noundef 11)
  %xor79 = xor i32 %call77, %call78
  %55 = load i32, ptr %e, align 4
  %call80 = call i32 @rotr(i32 noundef %55, i32 noundef 25)
  %xor81 = xor i32 %xor79, %call80
  store i32 %xor81, ptr %S1, align 4
  %56 = load i32, ptr %e, align 4
  %57 = load i32, ptr %f, align 4
  %and = and i32 %56, %57
  %58 = load i32, ptr %e, align 4
  %not = xor i32 %58, -1
  %59 = load i32, ptr %g, align 4
  %and82 = and i32 %not, %59
  %xor83 = xor i32 %and, %and82
  store i32 %xor83, ptr %ch, align 4
  %60 = load i32, ptr %h, align 4
  %61 = load i32, ptr %S1, align 4
  %add84 = add i32 %60, %61
  %62 = load i32, ptr %ch, align 4
  %add85 = add i32 %add84, %62
  %63 = load i32, ptr %i72, align 4
  %idxprom86 = sext i32 %63 to i64
  %arrayidx87 = getelementptr inbounds [64 x i32], ptr @K, i64 0, i64 %idxprom86
  %64 = load i32, ptr %arrayidx87, align 4
  %add88 = add i32 %add85, %64
  %65 = load i32, ptr %i72, align 4
  %idxprom89 = sext i32 %65 to i64
  %arrayidx90 = getelementptr inbounds [64 x i32], ptr %w, i64 0, i64 %idxprom89
  %66 = load i32, ptr %arrayidx90, align 4
  %add91 = add i32 %add88, %66
  store i32 %add91, ptr %temp1, align 4
  %67 = load i32, ptr %a, align 4
  %call92 = call i32 @rotr(i32 noundef %67, i32 noundef 2)
  %68 = load i32, ptr %a, align 4
  %call93 = call i32 @rotr(i32 noundef %68, i32 noundef 13)
  %xor94 = xor i32 %call92, %call93
  %69 = load i32, ptr %a, align 4
  %call95 = call i32 @rotr(i32 noundef %69, i32 noundef 22)
  %xor96 = xor i32 %xor94, %call95
  store i32 %xor96, ptr %S0, align 4
  %70 = load i32, ptr %a, align 4
  %71 = load i32, ptr %b, align 4
  %and97 = and i32 %70, %71
  %72 = load i32, ptr %a, align 4
  %73 = load i32, ptr %c, align 4
  %and98 = and i32 %72, %73
  %xor99 = xor i32 %and97, %and98
  %74 = load i32, ptr %b, align 4
  %75 = load i32, ptr %c, align 4
  %and100 = and i32 %74, %75
  %xor101 = xor i32 %xor99, %and100
  store i32 %xor101, ptr %maj, align 4
  %76 = load i32, ptr %S0, align 4
  %77 = load i32, ptr %maj, align 4
  %add102 = add i32 %76, %77
  store i32 %add102, ptr %temp2, align 4
  %78 = load i32, ptr %g, align 4
  store i32 %78, ptr %h, align 4
  %79 = load i32, ptr %f, align 4
  store i32 %79, ptr %g, align 4
  %80 = load i32, ptr %e, align 4
  store i32 %80, ptr %f, align 4
  %81 = load i32, ptr %d, align 4
  %82 = load i32, ptr %temp1, align 4
  %add103 = add i32 %81, %82
  store i32 %add103, ptr %e, align 4
  %83 = load i32, ptr %c, align 4
  store i32 %83, ptr %d, align 4
  %84 = load i32, ptr %b, align 4
  store i32 %84, ptr %c, align 4
  %85 = load i32, ptr %a, align 4
  store i32 %85, ptr %b, align 4
  %86 = load i32, ptr %temp1, align 4
  %87 = load i32, ptr %temp2, align 4
  %add104 = add i32 %86, %87
  store i32 %add104, ptr %a, align 4
  br label %for.inc105

for.inc105:                                       ; preds = %for.body76
  %88 = load i32, ptr %i72, align 4
  %inc106 = add nsw i32 %88, 1
  store i32 %inc106, ptr %i72, align 4
  br label %for.cond73, !llvm.loop !12

for.end107:                                       ; preds = %for.cond73
  %89 = load i32, ptr %a, align 4
  %90 = load ptr, ptr %state.addr, align 8
  %arrayidx108 = getelementptr inbounds i32, ptr %90, i64 0
  %91 = load i32, ptr %arrayidx108, align 4
  %add109 = add i32 %91, %89
  store i32 %add109, ptr %arrayidx108, align 4
  %92 = load i32, ptr %b, align 4
  %93 = load ptr, ptr %state.addr, align 8
  %arrayidx110 = getelementptr inbounds i32, ptr %93, i64 1
  %94 = load i32, ptr %arrayidx110, align 4
  %add111 = add i32 %94, %92
  store i32 %add111, ptr %arrayidx110, align 4
  %95 = load i32, ptr %c, align 4
  %96 = load ptr, ptr %state.addr, align 8
  %arrayidx112 = getelementptr inbounds i32, ptr %96, i64 2
  %97 = load i32, ptr %arrayidx112, align 4
  %add113 = add i32 %97, %95
  store i32 %add113, ptr %arrayidx112, align 4
  %98 = load i32, ptr %d, align 4
  %99 = load ptr, ptr %state.addr, align 8
  %arrayidx114 = getelementptr inbounds i32, ptr %99, i64 3
  %100 = load i32, ptr %arrayidx114, align 4
  %add115 = add i32 %100, %98
  store i32 %add115, ptr %arrayidx114, align 4
  %101 = load i32, ptr %e, align 4
  %102 = load ptr, ptr %state.addr, align 8
  %arrayidx116 = getelementptr inbounds i32, ptr %102, i64 4
  %103 = load i32, ptr %arrayidx116, align 4
  %add117 = add i32 %103, %101
  store i32 %add117, ptr %arrayidx116, align 4
  %104 = load i32, ptr %f, align 4
  %105 = load ptr, ptr %state.addr, align 8
  %arrayidx118 = getelementptr inbounds i32, ptr %105, i64 5
  %106 = load i32, ptr %arrayidx118, align 4
  %add119 = add i32 %106, %104
  store i32 %add119, ptr %arrayidx118, align 4
  %107 = load i32, ptr %g, align 4
  %108 = load ptr, ptr %state.addr, align 8
  %arrayidx120 = getelementptr inbounds i32, ptr %108, i64 6
  %109 = load i32, ptr %arrayidx120, align 4
  %add121 = add i32 %109, %107
  store i32 %add121, ptr %arrayidx120, align 4
  %110 = load i32, ptr %h, align 4
  %111 = load ptr, ptr %state.addr, align 8
  %arrayidx122 = getelementptr inbounds i32, ptr %111, i64 7
  %112 = load i32, ptr %arrayidx122, align 4
  %add123 = add i32 %112, %110
  store i32 %add123, ptr %arrayidx122, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @rotr(i32 noundef %x, i32 noundef %n) #0 {
entry:
  %x.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  store i32 %n, ptr %n.addr, align 4
  %0 = load i32, ptr %x.addr, align 4
  %1 = load i32, ptr %n.addr, align 4
  %shr = lshr i32 %0, %1
  %2 = load i32, ptr %x.addr, align 4
  %3 = load i32, ptr %n.addr, align 4
  %sub = sub i32 32, %3
  %shl = shl i32 %2, %sub
  %or = or i32 %shr, %shl
  ret i32 %or
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @chacha20_block(ptr noundef %out, ptr noundef %key, i32 noundef %counter, ptr noundef %nonce) #0 {
entry:
  %out.addr = alloca ptr, align 8
  %key.addr = alloca ptr, align 8
  %counter.addr = alloca i32, align 4
  %nonce.addr = alloca ptr, align 8
  %x = alloca [16 x i32], align 16
  %i = alloca i32, align 4
  %y = alloca [16 x i32], align 16
  %i10 = alloca i32, align 4
  %r = alloca i32, align 4
  %i59 = alloca i32, align 4
  store ptr %out, ptr %out.addr, align 8
  store ptr %key, ptr %key.addr, align 8
  store i32 %counter, ptr %counter.addr, align 4
  store ptr %nonce, ptr %nonce.addr, align 8
  %arraydecay = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 0
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %arraydecay, ptr align 16 @chacha20_sigma, i64 16, i1 false)
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 8
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load ptr, ptr %key.addr, align 8
  %2 = load i32, ptr %i, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds i32, ptr %1, i64 %idxprom
  %3 = load i32, ptr %arrayidx, align 4
  %4 = load i32, ptr %i, align 4
  %add = add nsw i32 4, %4
  %idxprom1 = sext i32 %add to i64
  %arrayidx2 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 %idxprom1
  store i32 %3, ptr %arrayidx2, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %5 = load i32, ptr %i, align 4
  %inc = add nsw i32 %5, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !13

for.end:                                          ; preds = %for.cond
  %6 = load i32, ptr %counter.addr, align 4
  %arrayidx3 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 12
  store i32 %6, ptr %arrayidx3, align 16
  %7 = load ptr, ptr %nonce.addr, align 8
  %arrayidx4 = getelementptr inbounds i32, ptr %7, i64 0
  %8 = load i32, ptr %arrayidx4, align 4
  %arrayidx5 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 13
  store i32 %8, ptr %arrayidx5, align 4
  %9 = load ptr, ptr %nonce.addr, align 8
  %arrayidx6 = getelementptr inbounds i32, ptr %9, i64 1
  %10 = load i32, ptr %arrayidx6, align 4
  %arrayidx7 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 14
  store i32 %10, ptr %arrayidx7, align 8
  %11 = load ptr, ptr %nonce.addr, align 8
  %arrayidx8 = getelementptr inbounds i32, ptr %11, i64 2
  %12 = load i32, ptr %arrayidx8, align 4
  %arrayidx9 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 15
  store i32 %12, ptr %arrayidx9, align 4
  store i32 0, ptr %i10, align 4
  br label %for.cond11

for.cond11:                                       ; preds = %for.inc18, %for.end
  %13 = load i32, ptr %i10, align 4
  %cmp12 = icmp slt i32 %13, 16
  br i1 %cmp12, label %for.body13, label %for.end20

for.body13:                                       ; preds = %for.cond11
  %14 = load i32, ptr %i10, align 4
  %idxprom14 = sext i32 %14 to i64
  %arrayidx15 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 %idxprom14
  %15 = load i32, ptr %arrayidx15, align 4
  %16 = load i32, ptr %i10, align 4
  %idxprom16 = sext i32 %16 to i64
  %arrayidx17 = getelementptr inbounds [16 x i32], ptr %y, i64 0, i64 %idxprom16
  store i32 %15, ptr %arrayidx17, align 4
  br label %for.inc18

for.inc18:                                        ; preds = %for.body13
  %17 = load i32, ptr %i10, align 4
  %inc19 = add nsw i32 %17, 1
  store i32 %inc19, ptr %i10, align 4
  br label %for.cond11, !llvm.loop !14

for.end20:                                        ; preds = %for.cond11
  store i32 0, ptr %r, align 4
  br label %for.cond21

for.cond21:                                       ; preds = %for.inc56, %for.end20
  %18 = load i32, ptr %r, align 4
  %cmp22 = icmp slt i32 %18, 10
  br i1 %cmp22, label %for.body23, label %for.end58

for.body23:                                       ; preds = %for.cond21
  %arrayidx24 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 0
  %arrayidx25 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 4
  %arrayidx26 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 8
  %arrayidx27 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 12
  call void @quarter_round(ptr noundef %arrayidx24, ptr noundef %arrayidx25, ptr noundef %arrayidx26, ptr noundef %arrayidx27)
  %arrayidx28 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 1
  %arrayidx29 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 5
  %arrayidx30 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 9
  %arrayidx31 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 13
  call void @quarter_round(ptr noundef %arrayidx28, ptr noundef %arrayidx29, ptr noundef %arrayidx30, ptr noundef %arrayidx31)
  %arrayidx32 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 2
  %arrayidx33 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 6
  %arrayidx34 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 10
  %arrayidx35 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 14
  call void @quarter_round(ptr noundef %arrayidx32, ptr noundef %arrayidx33, ptr noundef %arrayidx34, ptr noundef %arrayidx35)
  %arrayidx36 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 3
  %arrayidx37 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 7
  %arrayidx38 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 11
  %arrayidx39 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 15
  call void @quarter_round(ptr noundef %arrayidx36, ptr noundef %arrayidx37, ptr noundef %arrayidx38, ptr noundef %arrayidx39)
  %arrayidx40 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 0
  %arrayidx41 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 5
  %arrayidx42 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 10
  %arrayidx43 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 15
  call void @quarter_round(ptr noundef %arrayidx40, ptr noundef %arrayidx41, ptr noundef %arrayidx42, ptr noundef %arrayidx43)
  %arrayidx44 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 1
  %arrayidx45 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 6
  %arrayidx46 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 11
  %arrayidx47 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 12
  call void @quarter_round(ptr noundef %arrayidx44, ptr noundef %arrayidx45, ptr noundef %arrayidx46, ptr noundef %arrayidx47)
  %arrayidx48 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 2
  %arrayidx49 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 7
  %arrayidx50 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 8
  %arrayidx51 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 13
  call void @quarter_round(ptr noundef %arrayidx48, ptr noundef %arrayidx49, ptr noundef %arrayidx50, ptr noundef %arrayidx51)
  %arrayidx52 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 3
  %arrayidx53 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 4
  %arrayidx54 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 9
  %arrayidx55 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 14
  call void @quarter_round(ptr noundef %arrayidx52, ptr noundef %arrayidx53, ptr noundef %arrayidx54, ptr noundef %arrayidx55)
  br label %for.inc56

for.inc56:                                        ; preds = %for.body23
  %19 = load i32, ptr %r, align 4
  %inc57 = add nsw i32 %19, 1
  store i32 %inc57, ptr %r, align 4
  br label %for.cond21, !llvm.loop !15

for.end58:                                        ; preds = %for.cond21
  store i32 0, ptr %i59, align 4
  br label %for.cond60

for.cond60:                                       ; preds = %for.inc70, %for.end58
  %20 = load i32, ptr %i59, align 4
  %cmp61 = icmp slt i32 %20, 16
  br i1 %cmp61, label %for.body62, label %for.end72

for.body62:                                       ; preds = %for.cond60
  %21 = load i32, ptr %i59, align 4
  %idxprom63 = sext i32 %21 to i64
  %arrayidx64 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 %idxprom63
  %22 = load i32, ptr %arrayidx64, align 4
  %23 = load i32, ptr %i59, align 4
  %idxprom65 = sext i32 %23 to i64
  %arrayidx66 = getelementptr inbounds [16 x i32], ptr %y, i64 0, i64 %idxprom65
  %24 = load i32, ptr %arrayidx66, align 4
  %add67 = add i32 %22, %24
  %25 = load ptr, ptr %out.addr, align 8
  %26 = load i32, ptr %i59, align 4
  %idxprom68 = sext i32 %26 to i64
  %arrayidx69 = getelementptr inbounds i32, ptr %25, i64 %idxprom68
  store i32 %add67, ptr %arrayidx69, align 4
  br label %for.inc70

for.inc70:                                        ; preds = %for.body62
  %27 = load i32, ptr %i59, align 4
  %inc71 = add nsw i32 %27, 1
  store i32 %inc71, ptr %i59, align 4
  br label %for.cond60, !llvm.loop !16

for.end72:                                        ; preds = %for.cond60
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @quarter_round(ptr noundef %a, ptr noundef %b, ptr noundef %c, ptr noundef %d) #0 {
entry:
  %a.addr = alloca ptr, align 8
  %b.addr = alloca ptr, align 8
  %c.addr = alloca ptr, align 8
  %d.addr = alloca ptr, align 8
  store ptr %a, ptr %a.addr, align 8
  store ptr %b, ptr %b.addr, align 8
  store ptr %c, ptr %c.addr, align 8
  store ptr %d, ptr %d.addr, align 8
  %0 = load ptr, ptr %b.addr, align 8
  %1 = load i32, ptr %0, align 4
  %2 = load ptr, ptr %a.addr, align 8
  %3 = load i32, ptr %2, align 4
  %add = add i32 %3, %1
  store i32 %add, ptr %2, align 4
  %4 = load ptr, ptr %a.addr, align 8
  %5 = load i32, ptr %4, align 4
  %6 = load ptr, ptr %d.addr, align 8
  %7 = load i32, ptr %6, align 4
  %xor = xor i32 %7, %5
  store i32 %xor, ptr %6, align 4
  %8 = load ptr, ptr %d.addr, align 8
  %9 = load i32, ptr %8, align 4
  %call = call i32 @rotl(i32 noundef %9, i32 noundef 16)
  %10 = load ptr, ptr %d.addr, align 8
  store i32 %call, ptr %10, align 4
  %11 = load ptr, ptr %d.addr, align 8
  %12 = load i32, ptr %11, align 4
  %13 = load ptr, ptr %c.addr, align 8
  %14 = load i32, ptr %13, align 4
  %add1 = add i32 %14, %12
  store i32 %add1, ptr %13, align 4
  %15 = load ptr, ptr %c.addr, align 8
  %16 = load i32, ptr %15, align 4
  %17 = load ptr, ptr %b.addr, align 8
  %18 = load i32, ptr %17, align 4
  %xor2 = xor i32 %18, %16
  store i32 %xor2, ptr %17, align 4
  %19 = load ptr, ptr %b.addr, align 8
  %20 = load i32, ptr %19, align 4
  %call3 = call i32 @rotl(i32 noundef %20, i32 noundef 12)
  %21 = load ptr, ptr %b.addr, align 8
  store i32 %call3, ptr %21, align 4
  %22 = load ptr, ptr %b.addr, align 8
  %23 = load i32, ptr %22, align 4
  %24 = load ptr, ptr %a.addr, align 8
  %25 = load i32, ptr %24, align 4
  %add4 = add i32 %25, %23
  store i32 %add4, ptr %24, align 4
  %26 = load ptr, ptr %a.addr, align 8
  %27 = load i32, ptr %26, align 4
  %28 = load ptr, ptr %d.addr, align 8
  %29 = load i32, ptr %28, align 4
  %xor5 = xor i32 %29, %27
  store i32 %xor5, ptr %28, align 4
  %30 = load ptr, ptr %d.addr, align 8
  %31 = load i32, ptr %30, align 4
  %call6 = call i32 @rotl(i32 noundef %31, i32 noundef 8)
  %32 = load ptr, ptr %d.addr, align 8
  store i32 %call6, ptr %32, align 4
  %33 = load ptr, ptr %d.addr, align 8
  %34 = load i32, ptr %33, align 4
  %35 = load ptr, ptr %c.addr, align 8
  %36 = load i32, ptr %35, align 4
  %add7 = add i32 %36, %34
  store i32 %add7, ptr %35, align 4
  %37 = load ptr, ptr %c.addr, align 8
  %38 = load i32, ptr %37, align 4
  %39 = load ptr, ptr %b.addr, align 8
  %40 = load i32, ptr %39, align 4
  %xor8 = xor i32 %40, %38
  store i32 %xor8, ptr %39, align 4
  %41 = load ptr, ptr %b.addr, align 8
  %42 = load i32, ptr %41, align 4
  %call9 = call i32 @rotl(i32 noundef %42, i32 noundef 12)
  %43 = load ptr, ptr %b.addr, align 8
  store i32 %call9, ptr %43, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @md5_compress(ptr noundef %state, ptr noundef %block) #0 {
entry:
  %state.addr = alloca ptr, align 8
  %block.addr = alloca ptr, align 8
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %i = alloca i32, align 4
  %f = alloca i32, align 4
  %g = alloca i32, align 4
  %tmp = alloca i32, align 4
  store ptr %state, ptr %state.addr, align 8
  store ptr %block, ptr %block.addr, align 8
  %0 = load ptr, ptr %state.addr, align 8
  %arrayidx = getelementptr inbounds i32, ptr %0, i64 0
  %1 = load i32, ptr %arrayidx, align 4
  store i32 %1, ptr %a, align 4
  %2 = load ptr, ptr %state.addr, align 8
  %arrayidx1 = getelementptr inbounds i32, ptr %2, i64 1
  %3 = load i32, ptr %arrayidx1, align 4
  store i32 %3, ptr %b, align 4
  %4 = load ptr, ptr %state.addr, align 8
  %arrayidx2 = getelementptr inbounds i32, ptr %4, i64 2
  %5 = load i32, ptr %arrayidx2, align 4
  store i32 %5, ptr %c, align 4
  %6 = load ptr, ptr %state.addr, align 8
  %arrayidx3 = getelementptr inbounds i32, ptr %6, i64 3
  %7 = load i32, ptr %arrayidx3, align 4
  store i32 %7, ptr %d, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %8 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %8, 64
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %9 = load i32, ptr %i, align 4
  %cmp4 = icmp slt i32 %9, 16
  br i1 %cmp4, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %10 = load i32, ptr %b, align 4
  %11 = load i32, ptr %c, align 4
  %and = and i32 %10, %11
  %12 = load i32, ptr %b, align 4
  %not = xor i32 %12, -1
  %13 = load i32, ptr %d, align 4
  %and5 = and i32 %not, %13
  %or = or i32 %and, %and5
  store i32 %or, ptr %f, align 4
  %14 = load i32, ptr %i, align 4
  store i32 %14, ptr %g, align 4
  br label %if.end26

if.else:                                          ; preds = %for.body
  %15 = load i32, ptr %i, align 4
  %cmp6 = icmp slt i32 %15, 32
  br i1 %cmp6, label %if.then7, label %if.else12

if.then7:                                         ; preds = %if.else
  %16 = load i32, ptr %d, align 4
  %17 = load i32, ptr %b, align 4
  %and8 = and i32 %16, %17
  %18 = load i32, ptr %d, align 4
  %not9 = xor i32 %18, -1
  %19 = load i32, ptr %c, align 4
  %and10 = and i32 %not9, %19
  %or11 = or i32 %and8, %and10
  store i32 %or11, ptr %f, align 4
  %20 = load i32, ptr %i, align 4
  %mul = mul i32 5, %20
  %add = add i32 %mul, 1
  %rem = urem i32 %add, 16
  store i32 %rem, ptr %g, align 4
  br label %if.end25

if.else12:                                        ; preds = %if.else
  %21 = load i32, ptr %i, align 4
  %cmp13 = icmp slt i32 %21, 48
  br i1 %cmp13, label %if.then14, label %if.else19

if.then14:                                        ; preds = %if.else12
  %22 = load i32, ptr %b, align 4
  %23 = load i32, ptr %c, align 4
  %xor = xor i32 %22, %23
  %24 = load i32, ptr %d, align 4
  %xor15 = xor i32 %xor, %24
  store i32 %xor15, ptr %f, align 4
  %25 = load i32, ptr %i, align 4
  %mul16 = mul i32 3, %25
  %add17 = add i32 %mul16, 5
  %rem18 = urem i32 %add17, 16
  store i32 %rem18, ptr %g, align 4
  br label %if.end

if.else19:                                        ; preds = %if.else12
  %26 = load i32, ptr %c, align 4
  %27 = load i32, ptr %b, align 4
  %28 = load i32, ptr %d, align 4
  %not20 = xor i32 %28, -1
  %or21 = or i32 %27, %not20
  %xor22 = xor i32 %26, %or21
  store i32 %xor22, ptr %f, align 4
  %29 = load i32, ptr %i, align 4
  %mul23 = mul i32 7, %29
  %rem24 = urem i32 %mul23, 16
  store i32 %rem24, ptr %g, align 4
  br label %if.end

if.end:                                           ; preds = %if.else19, %if.then14
  br label %if.end25

if.end25:                                         ; preds = %if.end, %if.then7
  br label %if.end26

if.end26:                                         ; preds = %if.end25, %if.then
  %30 = load i32, ptr %d, align 4
  store i32 %30, ptr %tmp, align 4
  %31 = load i32, ptr %c, align 4
  store i32 %31, ptr %d, align 4
  %32 = load i32, ptr %b, align 4
  store i32 %32, ptr %c, align 4
  %33 = load i32, ptr %b, align 4
  %34 = load i32, ptr %a, align 4
  %35 = load i32, ptr %f, align 4
  %add27 = add i32 %34, %35
  %36 = load i32, ptr %i, align 4
  %idxprom = sext i32 %36 to i64
  %arrayidx28 = getelementptr inbounds [64 x i32], ptr @T, i64 0, i64 %idxprom
  %37 = load i32, ptr %arrayidx28, align 4
  %add29 = add i32 %add27, %37
  %38 = load ptr, ptr %block.addr, align 8
  %39 = load i32, ptr %g, align 4
  %idxprom30 = zext i32 %39 to i64
  %arrayidx31 = getelementptr inbounds i32, ptr %38, i64 %idxprom30
  %40 = load i32, ptr %arrayidx31, align 4
  %add32 = add i32 %add29, %40
  %41 = load i32, ptr %i, align 4
  %idxprom33 = sext i32 %41 to i64
  %arrayidx34 = getelementptr inbounds [64 x i32], ptr @md5_compress.s, i64 0, i64 %idxprom33
  %42 = load i32, ptr %arrayidx34, align 4
  %call = call i32 @md5_rotl(i32 noundef %add32, i32 noundef %42)
  %add35 = add i32 %33, %call
  store i32 %add35, ptr %b, align 4
  %43 = load i32, ptr %tmp, align 4
  store i32 %43, ptr %a, align 4
  br label %for.inc

for.inc:                                          ; preds = %if.end26
  %44 = load i32, ptr %i, align 4
  %inc = add nsw i32 %44, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !17

for.end:                                          ; preds = %for.cond
  %45 = load i32, ptr %a, align 4
  %46 = load ptr, ptr %state.addr, align 8
  %arrayidx36 = getelementptr inbounds i32, ptr %46, i64 0
  %47 = load i32, ptr %arrayidx36, align 4
  %add37 = add i32 %47, %45
  store i32 %add37, ptr %arrayidx36, align 4
  %48 = load i32, ptr %b, align 4
  %49 = load ptr, ptr %state.addr, align 8
  %arrayidx38 = getelementptr inbounds i32, ptr %49, i64 1
  %50 = load i32, ptr %arrayidx38, align 4
  %add39 = add i32 %50, %48
  store i32 %add39, ptr %arrayidx38, align 4
  %51 = load i32, ptr %c, align 4
  %52 = load ptr, ptr %state.addr, align 8
  %arrayidx40 = getelementptr inbounds i32, ptr %52, i64 2
  %53 = load i32, ptr %arrayidx40, align 4
  %add41 = add i32 %53, %51
  store i32 %add41, ptr %arrayidx40, align 4
  %54 = load i32, ptr %d, align 4
  %55 = load ptr, ptr %state.addr, align 8
  %arrayidx42 = getelementptr inbounds i32, ptr %55, i64 3
  %56 = load i32, ptr %arrayidx42, align 4
  %add43 = add i32 %56, %54
  store i32 %add43, ptr %arrayidx42, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @md5_rotl(i32 noundef %x, i32 noundef %n) #0 {
entry:
  %x.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  store i32 %n, ptr %n.addr, align 4
  %0 = load i32, ptr %x.addr, align 4
  %1 = load i32, ptr %n.addr, align 4
  %shl = shl i32 %0, %1
  %2 = load i32, ptr %x.addr, align 4
  %3 = load i32, ptr %n.addr, align 4
  %sub = sub nsw i32 32, %3
  %shr = lshr i32 %2, %sub
  %or = or i32 %shl, %shr
  ret i32 %or
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @rsa_modexp(i64 noundef %base, i64 noundef %exp, i64 noundef %mod) #0 {
entry:
  %base.addr = alloca i64, align 8
  %exp.addr = alloca i64, align 8
  %mod.addr = alloca i64, align 8
  %result = alloca i64, align 8
  store i64 %base, ptr %base.addr, align 8
  store i64 %exp, ptr %exp.addr, align 8
  store i64 %mod, ptr %mod.addr, align 8
  store i64 1, ptr %result, align 8
  %0 = load i64, ptr %mod.addr, align 8
  %1 = load i64, ptr %base.addr, align 8
  %rem = urem i64 %1, %0
  store i64 %rem, ptr %base.addr, align 8
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  %2 = load i64, ptr %exp.addr, align 8
  %cmp = icmp ugt i64 %2, 0
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %3 = load i64, ptr %exp.addr, align 8
  %and = and i64 %3, 1
  %tobool = icmp ne i64 %and, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %4 = load i64, ptr %result, align 8
  %5 = load i64, ptr %base.addr, align 8
  %mul = mul i64 %4, %5
  %6 = load i64, ptr %mod.addr, align 8
  %rem1 = urem i64 %mul, %6
  store i64 %rem1, ptr %result, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %while.body
  %7 = load i64, ptr %exp.addr, align 8
  %shr = lshr i64 %7, 1
  store i64 %shr, ptr %exp.addr, align 8
  %8 = load i64, ptr %base.addr, align 8
  %9 = load i64, ptr %base.addr, align 8
  %mul2 = mul i64 %8, %9
  %10 = load i64, ptr %mod.addr, align 8
  %rem3 = urem i64 %mul2, %10
  store i64 %rem3, ptr %base.addr, align 8
  br label %while.cond, !llvm.loop !18

while.end:                                        ; preds = %while.cond
  %11 = load i64, ptr %result, align 8
  ret i64 %11
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @inventory_sum(ptr noundef %items, i32 noundef %n) #0 {
entry:
  %items.addr = alloca ptr, align 8
  %n.addr = alloca i32, align 4
  %total = alloca i32, align 4
  %i = alloca i32, align 4
  store ptr %items, ptr %items.addr, align 8
  store i32 %n, ptr %n.addr, align 4
  store i32 0, ptr %total, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %1 = load i32, ptr %n.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load ptr, ptr %items.addr, align 8
  %3 = load i32, ptr %i, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx = getelementptr inbounds i32, ptr %2, i64 %idxprom
  %4 = load i32, ptr %arrayidx, align 4
  %5 = load i32, ptr %total, align 4
  %add = add nsw i32 %5, %4
  store i32 %add, ptr %total, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %6 = load i32, ptr %i, align 4
  %inc = add nsw i32 %6, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !19

for.end:                                          ; preds = %for.cond
  %7 = load i32, ptr %total, align 4
  ret i32 %7
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @copy_record(ptr noundef %dst, ptr noundef %src, i32 noundef %n) #0 {
entry:
  %dst.addr = alloca ptr, align 8
  %src.addr = alloca ptr, align 8
  %n.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store ptr %dst, ptr %dst.addr, align 8
  store ptr %src, ptr %src.addr, align 8
  store i32 %n, ptr %n.addr, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %1 = load i32, ptr %n.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load ptr, ptr %src.addr, align 8
  %3 = load i32, ptr %i, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx = getelementptr inbounds i8, ptr %2, i64 %idxprom
  %4 = load i8, ptr %arrayidx, align 1
  %5 = load ptr, ptr %dst.addr, align 8
  %6 = load i32, ptr %i, align 4
  %idxprom1 = sext i32 %6 to i64
  %arrayidx2 = getelementptr inbounds i8, ptr %5, i64 %idxprom1
  store i8 %4, ptr %arrayidx2, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %7 = load i32, ptr %i, align 4
  %inc = add nsw i32 %7, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !20

for.end:                                          ; preds = %for.cond
  %8 = load ptr, ptr %dst.addr, align 8
  %9 = load i32, ptr %n.addr, align 4
  %idxprom3 = sext i32 %9 to i64
  %arrayidx4 = getelementptr inbounds i8, ptr %8, i64 %idxprom3
  store i8 0, ptr %arrayidx4, align 1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @find_parcel(ptr noundef %ids, i32 noundef %n, i32 noundef %target) #0 {
entry:
  %retval = alloca i32, align 4
  %ids.addr = alloca ptr, align 8
  %n.addr = alloca i32, align 4
  %target.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store ptr %ids, ptr %ids.addr, align 8
  store i32 %n, ptr %n.addr, align 4
  store i32 %target, ptr %target.addr, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %1 = load i32, ptr %n.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load ptr, ptr %ids.addr, align 8
  %3 = load i32, ptr %i, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx = getelementptr inbounds i32, ptr %2, i64 %idxprom
  %4 = load i32, ptr %arrayidx, align 4
  %5 = load i32, ptr %target.addr, align 4
  %cmp1 = icmp eq i32 %4, %5
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %6 = load i32, ptr %i, align 4
  store i32 %6, ptr %retval, align 4
  br label %return

if.end:                                           ; preds = %for.body
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %7 = load i32, ptr %i, align 4
  %inc = add nsw i32 %7, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !21

for.end:                                          ; preds = %for.cond
  store i32 -1, ptr %retval, align 4
  br label %return

return:                                           ; preds = %for.end, %if.then
  %8 = load i32, ptr %retval, align 4
  ret i32 %8
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @rotl(i32 noundef %x, i32 noundef %n) #0 {
entry:
  %x.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  store i32 %n, ptr %n.addr, align 4
  %0 = load i32, ptr %x.addr, align 4
  %1 = load i32, ptr %n.addr, align 4
  %shl = shl i32 %0, %1
  %2 = load i32, ptr %x.addr, align 4
  %3 = load i32, ptr %n.addr, align 4
  %sub = sub nsw i32 32, %3
  %shr = lshr i32 %2, %sub
  %or = or i32 %shl, %shr
  ret i32 %or
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

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
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
!20 = distinct !{!20, !7}
!21 = distinct !{!21, !7}
