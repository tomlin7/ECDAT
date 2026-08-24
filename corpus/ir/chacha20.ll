; ModuleID = '/workspace/corpus/src/chacha20.c'
source_filename = "/workspace/corpus/src/chacha20.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@chacha20_sigma = dso_local constant [4 x i32] [i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236], align 16

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
  br label %for.cond, !llvm.loop !6

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
  br label %for.cond11, !llvm.loop !8

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
  br label %for.cond21, !llvm.loop !9

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
  br label %for.cond60, !llvm.loop !10

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
