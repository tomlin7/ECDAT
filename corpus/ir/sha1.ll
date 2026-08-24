; ModuleID = '/workspace/corpus/src/sha1.c'
source_filename = "/workspace/corpus/src/sha1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@K = internal constant [4 x i32] [i32 1518500249, i32 1859775393, i32 -1894007588, i32 -899497514], align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @sha1_compress(ptr noundef %state, ptr noundef %block) #0 {
entry:
  %state.addr = alloca ptr, align 8
  %block.addr = alloca ptr, align 8
  %w = alloca [80 x i32], align 16
  %i = alloca i32, align 4
  %i21 = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %e = alloca i32, align 4
  %i49 = alloca i32, align 4
  %f = alloca i32, align 4
  %k = alloca i32, align 4
  %temp = alloca i32, align 4
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
  %arrayidx20 = getelementptr inbounds [80 x i32], ptr %w, i64 0, i64 %idxprom19
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

for.cond22:                                       ; preds = %for.inc41, %for.end
  %15 = load i32, ptr %i21, align 4
  %cmp23 = icmp slt i32 %15, 80
  br i1 %cmp23, label %for.body25, label %for.end43

for.body25:                                       ; preds = %for.cond22
  %16 = load i32, ptr %i21, align 4
  %sub = sub nsw i32 %16, 3
  %idxprom26 = sext i32 %sub to i64
  %arrayidx27 = getelementptr inbounds [80 x i32], ptr %w, i64 0, i64 %idxprom26
  %17 = load i32, ptr %arrayidx27, align 4
  %18 = load i32, ptr %i21, align 4
  %sub28 = sub nsw i32 %18, 8
  %idxprom29 = sext i32 %sub28 to i64
  %arrayidx30 = getelementptr inbounds [80 x i32], ptr %w, i64 0, i64 %idxprom29
  %19 = load i32, ptr %arrayidx30, align 4
  %xor = xor i32 %17, %19
  %20 = load i32, ptr %i21, align 4
  %sub31 = sub nsw i32 %20, 14
  %idxprom32 = sext i32 %sub31 to i64
  %arrayidx33 = getelementptr inbounds [80 x i32], ptr %w, i64 0, i64 %idxprom32
  %21 = load i32, ptr %arrayidx33, align 4
  %xor34 = xor i32 %xor, %21
  %22 = load i32, ptr %i21, align 4
  %sub35 = sub nsw i32 %22, 16
  %idxprom36 = sext i32 %sub35 to i64
  %arrayidx37 = getelementptr inbounds [80 x i32], ptr %w, i64 0, i64 %idxprom36
  %23 = load i32, ptr %arrayidx37, align 4
  %xor38 = xor i32 %xor34, %23
  %call = call i32 @rotl(i32 noundef %xor38, i32 noundef 1)
  %24 = load i32, ptr %i21, align 4
  %idxprom39 = sext i32 %24 to i64
  %arrayidx40 = getelementptr inbounds [80 x i32], ptr %w, i64 0, i64 %idxprom39
  store i32 %call, ptr %arrayidx40, align 4
  br label %for.inc41

for.inc41:                                        ; preds = %for.body25
  %25 = load i32, ptr %i21, align 4
  %inc42 = add nsw i32 %25, 1
  store i32 %inc42, ptr %i21, align 4
  br label %for.cond22, !llvm.loop !8

for.end43:                                        ; preds = %for.cond22
  %26 = load ptr, ptr %state.addr, align 8
  %arrayidx44 = getelementptr inbounds i32, ptr %26, i64 0
  %27 = load i32, ptr %arrayidx44, align 4
  store i32 %27, ptr %a, align 4
  %28 = load ptr, ptr %state.addr, align 8
  %arrayidx45 = getelementptr inbounds i32, ptr %28, i64 1
  %29 = load i32, ptr %arrayidx45, align 4
  store i32 %29, ptr %b, align 4
  %30 = load ptr, ptr %state.addr, align 8
  %arrayidx46 = getelementptr inbounds i32, ptr %30, i64 2
  %31 = load i32, ptr %arrayidx46, align 4
  store i32 %31, ptr %c, align 4
  %32 = load ptr, ptr %state.addr, align 8
  %arrayidx47 = getelementptr inbounds i32, ptr %32, i64 3
  %33 = load i32, ptr %arrayidx47, align 4
  store i32 %33, ptr %d, align 4
  %34 = load ptr, ptr %state.addr, align 8
  %arrayidx48 = getelementptr inbounds i32, ptr %34, i64 4
  %35 = load i32, ptr %arrayidx48, align 4
  store i32 %35, ptr %e, align 4
  store i32 0, ptr %i49, align 4
  br label %for.cond50

for.cond50:                                       ; preds = %for.inc85, %for.end43
  %36 = load i32, ptr %i49, align 4
  %cmp51 = icmp slt i32 %36, 80
  br i1 %cmp51, label %for.body53, label %for.end87

for.body53:                                       ; preds = %for.cond50
  %37 = load i32, ptr %i49, align 4
  %cmp54 = icmp slt i32 %37, 20
  br i1 %cmp54, label %if.then, label %if.else

if.then:                                          ; preds = %for.body53
  %38 = load i32, ptr %b, align 4
  %39 = load i32, ptr %c, align 4
  %and = and i32 %38, %39
  %40 = load i32, ptr %b, align 4
  %not = xor i32 %40, -1
  %41 = load i32, ptr %d, align 4
  %and56 = and i32 %not, %41
  %or57 = or i32 %and, %and56
  store i32 %or57, ptr %f, align 4
  %42 = load i32, ptr @K, align 16
  store i32 %42, ptr %k, align 4
  br label %if.end76

if.else:                                          ; preds = %for.body53
  %43 = load i32, ptr %i49, align 4
  %cmp58 = icmp slt i32 %43, 40
  br i1 %cmp58, label %if.then60, label %if.else63

if.then60:                                        ; preds = %if.else
  %44 = load i32, ptr %b, align 4
  %45 = load i32, ptr %c, align 4
  %xor61 = xor i32 %44, %45
  %46 = load i32, ptr %d, align 4
  %xor62 = xor i32 %xor61, %46
  store i32 %xor62, ptr %f, align 4
  %47 = load i32, ptr getelementptr inbounds ([4 x i32], ptr @K, i64 0, i64 1), align 4
  store i32 %47, ptr %k, align 4
  br label %if.end75

if.else63:                                        ; preds = %if.else
  %48 = load i32, ptr %i49, align 4
  %cmp64 = icmp slt i32 %48, 60
  br i1 %cmp64, label %if.then66, label %if.else72

if.then66:                                        ; preds = %if.else63
  %49 = load i32, ptr %b, align 4
  %50 = load i32, ptr %c, align 4
  %and67 = and i32 %49, %50
  %51 = load i32, ptr %b, align 4
  %52 = load i32, ptr %d, align 4
  %and68 = and i32 %51, %52
  %or69 = or i32 %and67, %and68
  %53 = load i32, ptr %c, align 4
  %54 = load i32, ptr %d, align 4
  %and70 = and i32 %53, %54
  %or71 = or i32 %or69, %and70
  store i32 %or71, ptr %f, align 4
  %55 = load i32, ptr getelementptr inbounds ([4 x i32], ptr @K, i64 0, i64 2), align 8
  store i32 %55, ptr %k, align 4
  br label %if.end

if.else72:                                        ; preds = %if.else63
  %56 = load i32, ptr %b, align 4
  %57 = load i32, ptr %c, align 4
  %xor73 = xor i32 %56, %57
  %58 = load i32, ptr %d, align 4
  %xor74 = xor i32 %xor73, %58
  store i32 %xor74, ptr %f, align 4
  %59 = load i32, ptr getelementptr inbounds ([4 x i32], ptr @K, i64 0, i64 3), align 4
  store i32 %59, ptr %k, align 4
  br label %if.end

if.end:                                           ; preds = %if.else72, %if.then66
  br label %if.end75

if.end75:                                         ; preds = %if.end, %if.then60
  br label %if.end76

if.end76:                                         ; preds = %if.end75, %if.then
  %60 = load i32, ptr %a, align 4
  %call77 = call i32 @rotl(i32 noundef %60, i32 noundef 5)
  %61 = load i32, ptr %f, align 4
  %add78 = add i32 %call77, %61
  %62 = load i32, ptr %e, align 4
  %add79 = add i32 %add78, %62
  %63 = load i32, ptr %k, align 4
  %add80 = add i32 %add79, %63
  %64 = load i32, ptr %i49, align 4
  %idxprom81 = sext i32 %64 to i64
  %arrayidx82 = getelementptr inbounds [80 x i32], ptr %w, i64 0, i64 %idxprom81
  %65 = load i32, ptr %arrayidx82, align 4
  %add83 = add i32 %add80, %65
  store i32 %add83, ptr %temp, align 4
  %66 = load i32, ptr %d, align 4
  store i32 %66, ptr %e, align 4
  %67 = load i32, ptr %c, align 4
  store i32 %67, ptr %d, align 4
  %68 = load i32, ptr %b, align 4
  %call84 = call i32 @rotl(i32 noundef %68, i32 noundef 30)
  store i32 %call84, ptr %c, align 4
  %69 = load i32, ptr %a, align 4
  store i32 %69, ptr %b, align 4
  %70 = load i32, ptr %temp, align 4
  store i32 %70, ptr %a, align 4
  br label %for.inc85

for.inc85:                                        ; preds = %if.end76
  %71 = load i32, ptr %i49, align 4
  %inc86 = add nsw i32 %71, 1
  store i32 %inc86, ptr %i49, align 4
  br label %for.cond50, !llvm.loop !9

for.end87:                                        ; preds = %for.cond50
  %72 = load i32, ptr %a, align 4
  %73 = load ptr, ptr %state.addr, align 8
  %arrayidx88 = getelementptr inbounds i32, ptr %73, i64 0
  %74 = load i32, ptr %arrayidx88, align 4
  %add89 = add i32 %74, %72
  store i32 %add89, ptr %arrayidx88, align 4
  %75 = load i32, ptr %b, align 4
  %76 = load ptr, ptr %state.addr, align 8
  %arrayidx90 = getelementptr inbounds i32, ptr %76, i64 1
  %77 = load i32, ptr %arrayidx90, align 4
  %add91 = add i32 %77, %75
  store i32 %add91, ptr %arrayidx90, align 4
  %78 = load i32, ptr %c, align 4
  %79 = load ptr, ptr %state.addr, align 8
  %arrayidx92 = getelementptr inbounds i32, ptr %79, i64 2
  %80 = load i32, ptr %arrayidx92, align 4
  %add93 = add i32 %80, %78
  store i32 %add93, ptr %arrayidx92, align 4
  %81 = load i32, ptr %d, align 4
  %82 = load ptr, ptr %state.addr, align 8
  %arrayidx94 = getelementptr inbounds i32, ptr %82, i64 3
  %83 = load i32, ptr %arrayidx94, align 4
  %add95 = add i32 %83, %81
  store i32 %add95, ptr %arrayidx94, align 4
  %84 = load i32, ptr %e, align 4
  %85 = load ptr, ptr %state.addr, align 8
  %arrayidx96 = getelementptr inbounds i32, ptr %85, i64 4
  %86 = load i32, ptr %arrayidx96, align 4
  %add97 = add i32 %86, %84
  store i32 %add97, ptr %arrayidx96, align 4
  ret void
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
