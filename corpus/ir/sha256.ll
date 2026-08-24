; ModuleID = '/workspace/corpus/src/sha256.c'
source_filename = "/workspace/corpus/src/sha256.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@K = internal constant [64 x i32] [i32 1116352408, i32 1899447441, i32 -1245643825, i32 -373957723, i32 961987163, i32 1508970993, i32 -1841331548, i32 -1424204075, i32 -670586216, i32 310598401, i32 607225278, i32 1426881987, i32 1925078388, i32 -2132889090, i32 -1680079193, i32 -1046744716, i32 -459576895, i32 -272742522, i32 264347078, i32 604807628, i32 770255983, i32 1249150122, i32 1555081692, i32 1996064986, i32 -1740746414, i32 -1473132947, i32 -1341970488, i32 -1084653625, i32 -958395405, i32 -710438585, i32 113926993, i32 338241895, i32 666307205, i32 773529912, i32 1294757372, i32 1396182291, i32 1695183700, i32 1986661051, i32 -2117940946, i32 -1838011259, i32 -1564481375, i32 -1474664885, i32 -1035236496, i32 -949202525, i32 -778901479, i32 -694614492, i32 -200395387, i32 275423344, i32 430227734, i32 506948616, i32 659060556, i32 883997877, i32 958139571, i32 1322822218, i32 1537002063, i32 1747873779, i32 1955562222, i32 2024104815, i32 -2067236844, i32 -1933114872, i32 -1866530822, i32 -1538233109, i32 -1090935817, i32 -965641998], align 16

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
  br label %for.cond, !llvm.loop !6

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
  br label %for.cond22, !llvm.loop !8

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
  br label %for.cond73, !llvm.loop !9

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
