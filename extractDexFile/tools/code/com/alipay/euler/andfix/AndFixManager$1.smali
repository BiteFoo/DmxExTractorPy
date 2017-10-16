.class Lcom/alipay/euler/andfix/AndFixManager$1;
.super Ljava/lang/ClassLoader;
.source "AndFixManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alipay/euler/andfix/AndFixManager;->fix(Ljava/io/File;Ljava/lang/ClassLoader;Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/alipay/euler/andfix/AndFixManager;

.field private final synthetic val$dexFile:Ldalvik/system/DexFile;


# direct methods
.method constructor <init>(Lcom/alipay/euler/andfix/AndFixManager;Ljava/lang/ClassLoader;Ldalvik/system/DexFile;)V
    .locals 0
    .param p2, "$anonymous0"    # Ljava/lang/ClassLoader;

    .prologue
    .line 1
    iput-object p1, p0, Lcom/alipay/euler/andfix/AndFixManager$1;->this$0:Lcom/alipay/euler/andfix/AndFixManager;

    iput-object p3, p0, Lcom/alipay/euler/andfix/AndFixManager$1;->val$dexFile:Ldalvik/system/DexFile;

    .line 158
    invoke-direct {p0, p2}, Ljava/lang/ClassLoader;-><init>(Ljava/lang/ClassLoader;)V

    return-void
.end method


# virtual methods
.method protected findClass(Ljava/lang/String;)Ljava/lang/Class;
    .locals 4
    .param p1, "className"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/Class",
            "<*>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ClassNotFoundException;
        }
    .end annotation

    .prologue
    .line 162
    iget-object v1, p0, Lcom/alipay/euler/andfix/AndFixManager$1;->val$dexFile:Ldalvik/system/DexFile;

    invoke-virtual {v1, p1, p0}, Ldalvik/system/DexFile;->loadClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    .line 163
    .local v0, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v1, "AndFixManager"

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "fix findClass="

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 164
    if-nez v0, :cond_1

    .line 165
    const-string v1, "com.alipay.euler.andfix"

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 166
    invoke-static {p1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 172
    .end local v0    # "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :cond_0
    return-object v0

    .line 169
    .restart local v0    # "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :cond_1
    if-nez v0, :cond_0

    .line 170
    new-instance v1, Ljava/lang/ClassNotFoundException;

    invoke-direct {v1, p1}, Ljava/lang/ClassNotFoundException;-><init>(Ljava/lang/String;)V

    throw v1
.end method
