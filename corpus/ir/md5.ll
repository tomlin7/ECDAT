; ModuleID = '/workspace/corpus/src/md5.c'
source_filename = "/workspace/corpus/src/md5.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@md5_compress.s = internal constant [64 x i32] [i32 7, i32 12, i32 17, i32 22, i32 7, i32 12, i32 17, i32 22, i32 7, i32 12, i32 17, i32 22, i32 7, i32 12, i32 17, i32 22, i32 5, i32 9, i32 14, i32 20, i32 5, i32 9, i32 14, i32 20, i32 5, i32 9, i32 14, i32 20, i32 5, i32 9, i32 14, i32 20, i32 4, i32 11, i32 16, i32 23, i32 4, i32 11, i32 16, i32 23, i32 4, i32 11, i32 16, i32 23, i32 4, i32 11, i32 16, i32 23, i32 6, i32 10, i32 15, i32 21, i32 6, i32 10, i32 15, i32 21, i32 6, i32 10, i32 15, i32 21, i32 6, i32 10, i32 15, i32 21], align 16
@T = internal constant [64 x i32] [i32 -680876936, i32 -389564586, i32 606105819, i32 -1044525330, i32 -176418897, i32 1200080426, i32 -1473231341, i32 -45705983, i32 1770035416, i32 -1958414417, i32 -42063, i32 -1990404162, i32 1804603682, i32 -40341101, i32 -1502002290, i32 1236535329, i32 -165796510, i32 -1069501632, i32 643717713, i32 -373897302, i32 -701558691, i32 38016083, i32 -660478335, i32 -405537848, i32 568446438, i32 -1019803690, i32 -187363961, i32 1163531501, i32 -1444681467, i32 -51403784, i32 1735328473, i32 -1926607734, i32 -378558, i32 -2022574463, i32 1839030562, i32 -35309556, i32 -1530992060, i32 1272893353, i32 -155497632, i32 -1094730640, i32 681279174, i32 -358537222, i32 -722521979, i32 76029189, i32 -640364487, i32 -421815835, i32 530742520, i32 -995338651, i32 -198630844, i32 1126891415, i32 -1416354905, i32 -57434055, i32 1700485571, i32 -1894986606, i32 -1051523, i32 -2054922799, i32 1873313359, i32 -30611744, i32 -1560198380, i32 1309151649, i32 -145523070, i32 -1120210379, i32 718787259, i32 -343485551], align 16

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
  br label %for.cond, !llvm.loop !6

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
