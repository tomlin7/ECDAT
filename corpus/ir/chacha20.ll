; ModuleID = '/workspace/corpus/src/chacha20.c'
source_filename = "/workspace/corpus/src/chacha20.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sigma = internal constant [4 x i32] [i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236], align 16

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
  %i14 = alloca i32, align 4
  %r = alloca i32, align 4
  %i63 = alloca i32, align 4
  store ptr %out, ptr %out.addr, align 8
  store ptr %key, ptr %key.addr, align 8
  store i32 %counter, ptr %counter.addr, align 4
  store ptr %nonce, ptr %nonce.addr, align 8
  %0 = load i32, ptr @sigma, align 16
  %arrayidx = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 0
  store i32 %0, ptr %arrayidx, align 16
  %1 = load i32, ptr getelementptr inbounds ([4 x i32], ptr @sigma, i64 0, i64 1), align 4
  %arrayidx1 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 1
  store i32 %1, ptr %arrayidx1, align 4
  %2 = load i32, ptr getelementptr inbounds ([4 x i32], ptr @sigma, i64 0, i64 2), align 8
  %arrayidx2 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 2
  store i32 %2, ptr %arrayidx2, align 8
  %3 = load i32, ptr getelementptr inbounds ([4 x i32], ptr @sigma, i64 0, i64 3), align 4
  %arrayidx3 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 3
  store i32 %3, ptr %arrayidx3, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %4, 8
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %5 = load ptr, ptr %key.addr, align 8
  %6 = load i32, ptr %i, align 4
  %idxprom = sext i32 %6 to i64
  %arrayidx4 = getelementptr inbounds i32, ptr %5, i64 %idxprom
  %7 = load i32, ptr %arrayidx4, align 4
  %8 = load i32, ptr %i, align 4
  %add = add nsw i32 4, %8
  %idxprom5 = sext i32 %add to i64
  %arrayidx6 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 %idxprom5
  store i32 %7, ptr %arrayidx6, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %9 = load i32, ptr %i, align 4
  %inc = add nsw i32 %9, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  %10 = load i32, ptr %counter.addr, align 4
  %arrayidx7 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 12
  store i32 %10, ptr %arrayidx7, align 16
  %11 = load ptr, ptr %nonce.addr, align 8
  %arrayidx8 = getelementptr inbounds i32, ptr %11, i64 0
  %12 = load i32, ptr %arrayidx8, align 4
  %arrayidx9 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 13
  store i32 %12, ptr %arrayidx9, align 4
  %13 = load ptr, ptr %nonce.addr, align 8
  %arrayidx10 = getelementptr inbounds i32, ptr %13, i64 1
  %14 = load i32, ptr %arrayidx10, align 4
  %arrayidx11 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 14
  store i32 %14, ptr %arrayidx11, align 8
  %15 = load ptr, ptr %nonce.addr, align 8
  %arrayidx12 = getelementptr inbounds i32, ptr %15, i64 2
  %16 = load i32, ptr %arrayidx12, align 4
  %arrayidx13 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 15
  store i32 %16, ptr %arrayidx13, align 4
  store i32 0, ptr %i14, align 4
  br label %for.cond15

for.cond15:                                       ; preds = %for.inc22, %for.end
  %17 = load i32, ptr %i14, align 4
  %cmp16 = icmp slt i32 %17, 16
  br i1 %cmp16, label %for.body17, label %for.end24

for.body17:                                       ; preds = %for.cond15
  %18 = load i32, ptr %i14, align 4
  %idxprom18 = sext i32 %18 to i64
  %arrayidx19 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 %idxprom18
  %19 = load i32, ptr %arrayidx19, align 4
  %20 = load i32, ptr %i14, align 4
  %idxprom20 = sext i32 %20 to i64
  %arrayidx21 = getelementptr inbounds [16 x i32], ptr %y, i64 0, i64 %idxprom20
  store i32 %19, ptr %arrayidx21, align 4
  br label %for.inc22

for.inc22:                                        ; preds = %for.body17
  %21 = load i32, ptr %i14, align 4
  %inc23 = add nsw i32 %21, 1
  store i32 %inc23, ptr %i14, align 4
  br label %for.cond15, !llvm.loop !8

for.end24:                                        ; preds = %for.cond15
  store i32 0, ptr %r, align 4
  br label %for.cond25

for.cond25:                                       ; preds = %for.inc60, %for.end24
  %22 = load i32, ptr %r, align 4
  %cmp26 = icmp slt i32 %22, 10
  br i1 %cmp26, label %for.body27, label %for.end62

for.body27:                                       ; preds = %for.cond25
  %arrayidx28 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 0
  %arrayidx29 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 4
  %arrayidx30 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 8
  %arrayidx31 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 12
  call void @quarter_round(ptr noundef %arrayidx28, ptr noundef %arrayidx29, ptr noundef %arrayidx30, ptr noundef %arrayidx31)
  %arrayidx32 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 1
  %arrayidx33 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 5
  %arrayidx34 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 9
  %arrayidx35 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 13
  call void @quarter_round(ptr noundef %arrayidx32, ptr noundef %arrayidx33, ptr noundef %arrayidx34, ptr noundef %arrayidx35)
  %arrayidx36 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 2
  %arrayidx37 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 6
  %arrayidx38 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 10
  %arrayidx39 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 14
  call void @quarter_round(ptr noundef %arrayidx36, ptr noundef %arrayidx37, ptr noundef %arrayidx38, ptr noundef %arrayidx39)
  %arrayidx40 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 3
  %arrayidx41 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 7
  %arrayidx42 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 11
  %arrayidx43 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 15
  call void @quarter_round(ptr noundef %arrayidx40, ptr noundef %arrayidx41, ptr noundef %arrayidx42, ptr noundef %arrayidx43)
  %arrayidx44 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 0
  %arrayidx45 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 5
  %arrayidx46 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 10
  %arrayidx47 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 15
  call void @quarter_round(ptr noundef %arrayidx44, ptr noundef %arrayidx45, ptr noundef %arrayidx46, ptr noundef %arrayidx47)
  %arrayidx48 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 1
  %arrayidx49 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 6
  %arrayidx50 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 11
  %arrayidx51 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 12
  call void @quarter_round(ptr noundef %arrayidx48, ptr noundef %arrayidx49, ptr noundef %arrayidx50, ptr noundef %arrayidx51)
  %arrayidx52 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 2
  %arrayidx53 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 7
  %arrayidx54 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 8
  %arrayidx55 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 13
  call void @quarter_round(ptr noundef %arrayidx52, ptr noundef %arrayidx53, ptr noundef %arrayidx54, ptr noundef %arrayidx55)
  %arrayidx56 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 3
  %arrayidx57 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 4
  %arrayidx58 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 9
  %arrayidx59 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 14
  call void @quarter_round(ptr noundef %arrayidx56, ptr noundef %arrayidx57, ptr noundef %arrayidx58, ptr noundef %arrayidx59)
  br label %for.inc60

for.inc60:                                        ; preds = %for.body27
  %23 = load i32, ptr %r, align 4
  %inc61 = add nsw i32 %23, 1
  store i32 %inc61, ptr %r, align 4
  br label %for.cond25, !llvm.loop !9

for.end62:                                        ; preds = %for.cond25
  store i32 0, ptr %i63, align 4
  br label %for.cond64

for.cond64:                                       ; preds = %for.inc74, %for.end62
  %24 = load i32, ptr %i63, align 4
  %cmp65 = icmp slt i32 %24, 16
  br i1 %cmp65, label %for.body66, label %for.end76

for.body66:                                       ; preds = %for.cond64
  %25 = load i32, ptr %i63, align 4
  %idxprom67 = sext i32 %25 to i64
  %arrayidx68 = getelementptr inbounds [16 x i32], ptr %x, i64 0, i64 %idxprom67
  %26 = load i32, ptr %arrayidx68, align 4
  %27 = load i32, ptr %i63, align 4
  %idxprom69 = sext i32 %27 to i64
  %arrayidx70 = getelementptr inbounds [16 x i32], ptr %y, i64 0, i64 %idxprom69
  %28 = load i32, ptr %arrayidx70, align 4
  %add71 = add i32 %26, %28
  %29 = load ptr, ptr %out.addr, align 8
  %30 = load i32, ptr %i63, align 4
  %idxprom72 = sext i32 %30 to i64
  %arrayidx73 = getelementptr inbounds i32, ptr %29, i64 %idxprom72
  store i32 %add71, ptr %arrayidx73, align 4
  br label %for.inc74

for.inc74:                                        ; preds = %for.body66
  %31 = load i32, ptr %i63, align 4
  %inc75 = add nsw i32 %31, 1
  store i32 %inc75, ptr %i63, align 4
  br label %for.cond64, !llvm.loop !10

for.end76:                                        ; preds = %for.cond64
  ret void
}

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
!10 = distinct !{!10, !7}
