.class public abstract Litsec/parserelf/BaseTest;
.super Ljava/lang/Object;
.source "BaseTest.java"


# direct methods
.method static constructor <clinit>()V
    .locals 1
    .prologue
 const-class v0, Litsec/parserelf/BaseTest;

    invoke-static {v0}, Lcom/alipay/euler/andfix/AndFixManager;->fixfunc(Ljava/lang/Class;)V
    return-void
.end method
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public abstract getAget()I
.end method

.method public abstract getName()Ljava/lang/String;
.end method

