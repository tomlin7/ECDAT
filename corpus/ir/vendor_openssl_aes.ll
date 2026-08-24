; ModuleID = '/workspace/corpus/src/vendor_openssl_aes.c'
source_filename = "/workspace/corpus/src/vendor_openssl_aes.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@Te0 = internal constant [16 x i32] [i32 -966564955, i32 -126059388, i32 -294160487, i32 -159679603, i32 -855539, i32 -697603139, i32 -563122255, i32 -1849309868, i32 1613770832, i32 33620227, i32 -832084055, i32 1445669757, i32 -402719207, i32 -1244145822, i32 1303096294, i32 -327780710], align 16
@Te4 = internal constant [256 x i8] c"c|w{\F2ko\C50\01g+\FE\D7\ABv\CA\82\C9}\FAYG\F0\AD\D4\A2\AF\9C\A4r\C0\B7\FD\93&6?\F7\CC4\A5\E5\F1q\D81\15\04\C7#\C3\18\96\05\9A\07\12\80\E2\EB'\B2u\09\83,\1A\1BnZ\A0R;\D6\B3)\E3/\84S\D1\00\ED \FC\B1[j\CB\BE9JLX\CF\D0\EF\AA\FBCM3\85E\F9\02\7FP<\9F\A8Q\A3@\8F\92\9D8\F5\BC\B6\DA!\10\FF\F3\D2\CD\0C\13\EC_\97D\17\C4\A7~=d]\19s`\81O\DC\22*\90\88F\EE\B8\14\DE^\0B\DB\E02:\0AI\06$\\\C2\D3\ACb\91\95\E4y\E7\C87m\8D\D5N\A9lV\F4\EAez\AE\08\BAx%.\1C\A6\B4\C6\E8\DDt\1FK\BD\8B\8Ap>\B5fH\03\F6\0Ea5W\B9\86\C1\1D\9E\E1\F8\98\11i\D9\8E\94\9B\1E\87\E9\CEU(\DF\8C\A1\89\0D\BF\E6BhA\99-\0F\B0T\BB\16", align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @_v0(i32 noundef %w) #0 {
entry:
  %w.addr = alloca i32, align 4
  store i32 %w, ptr %w.addr, align 4
  %0 = load i32, ptr %w.addr, align 4
  %shr = lshr i32 %0, 24
  %and = and i32 %shr, 15
  %idxprom = zext i32 %and to i64
  %arrayidx = getelementptr inbounds [16 x i32], ptr @Te0, i64 0, i64 %idxprom
  %1 = load i32, ptr %arrayidx, align 4
  %2 = load i32, ptr %w.addr, align 4
  %and1 = and i32 %2, 15
  %idxprom2 = zext i32 %and1 to i64
  %arrayidx3 = getelementptr inbounds [16 x i32], ptr @Te0, i64 0, i64 %idxprom2
  %3 = load i32, ptr %arrayidx3, align 4
  %xor = xor i32 %1, %3
  ret i32 %xor
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i8 @_v1(i8 noundef zeroext %x) #0 {
entry:
  %x.addr = alloca i8, align 1
  store i8 %x, ptr %x.addr, align 1
  %0 = load i8, ptr %x.addr, align 1
  %idxprom = zext i8 %0 to i64
  %arrayidx = getelementptr inbounds [256 x i8], ptr @Te4, i64 0, i64 %idxprom
  %1 = load i8, ptr %arrayidx, align 1
  ret i8 %1
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
