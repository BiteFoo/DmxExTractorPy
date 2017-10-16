.class public Lcom/alipay/euler/andfix/AndFixManager;
.super Ljava/lang/Object;
.source "AndFixManager.java"


# static fields
.field private static final DIR:Ljava/lang/String; = "apatch_opt"

.field private static final TAG:Ljava/lang/String; = "AndFixManager"

.field public static classLoader:Ljava/lang/ClassLoader;

.field public static dexFile:Ldalvik/system/DexFile;

.field private static mFixedClass:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Class",
            "<*>;>;"
        }
    .end annotation
.end field

.field public static patchClassLoader:Ljava/lang/ClassLoader;


# instance fields
.field private final mContext:Landroid/content/Context;

.field private mOptDir:Ljava/io/File;

.field private mSecurityChecker:Lcom/alipay/euler/andfix/security/SecurityChecker;

.field private mSupport:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 55
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lcom/alipay/euler/andfix/AndFixManager;->mFixedClass:Ljava/util/Map;

    .line 113
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v3, 0x0

    .line 72
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 60
    iput-boolean v3, p0, Lcom/alipay/euler/andfix/AndFixManager;->mSupport:Z

    .line 73
    iput-object p1, p0, Lcom/alipay/euler/andfix/AndFixManager;->mContext:Landroid/content/Context;

    .line 74
    invoke-static {}, Lcom/alipay/euler/andfix/Compat;->isSupport()Z

    move-result v0

    iput-boolean v0, p0, Lcom/alipay/euler/andfix/AndFixManager;->mSupport:Z

    .line 75
    iget-boolean v0, p0, Lcom/alipay/euler/andfix/AndFixManager;->mSupport:Z

    if-eqz v0, :cond_0

    .line 76
    new-instance v0, Lcom/alipay/euler/andfix/security/SecurityChecker;

    iget-object v1, p0, Lcom/alipay/euler/andfix/AndFixManager;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/alipay/euler/andfix/security/SecurityChecker;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/alipay/euler/andfix/AndFixManager;->mSecurityChecker:Lcom/alipay/euler/andfix/security/SecurityChecker;

    .line 77
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/alipay/euler/andfix/AndFixManager;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "apatch_opt"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/alipay/euler/andfix/AndFixManager;->mOptDir:Ljava/io/File;

    .line 78
    iget-object v0, p0, Lcom/alipay/euler/andfix/AndFixManager;->mOptDir:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/alipay/euler/andfix/AndFixManager;->mOptDir:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    move-result v0

    if-nez v0, :cond_1

    .line 79
    iput-boolean v3, p0, Lcom/alipay/euler/andfix/AndFixManager;->mSupport:Z

    .line 80
    const-string v0, "AndFixManager"

    const-string v1, "opt dir create error."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 86
    :cond_0
    :goto_0
    return-void

    .line 81
    :cond_1
    iget-object v0, p0, Lcom/alipay/euler/andfix/AndFixManager;->mOptDir:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-nez v0, :cond_0

    .line 82
    iget-object v0, p0, Lcom/alipay/euler/andfix/AndFixManager;->mOptDir:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 83
    iput-boolean v3, p0, Lcom/alipay/euler/andfix/AndFixManager;->mSupport:Z

    goto :goto_0
.end method

.method private static fixClass(Ljava/lang/Class;Ljava/lang/ClassLoader;)V
    .locals 8
    .param p1, "classLoader"    # Ljava/lang/ClassLoader;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<*>;",
            "Ljava/lang/ClassLoader;",
            ")V"
        }
    .end annotation

    .prologue
    .line 251
    .local p0, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    invoke-virtual {p0}, Ljava/lang/Class;->getDeclaredMethods()[Ljava/lang/reflect/Method;

    move-result-object v4

    .line 255
    .local v4, "methods":[Ljava/lang/reflect/Method;
    array-length v6, v4

    const/4 v5, 0x0

    :goto_0
    if-lt v5, v6, :cond_0

    .line 266
    return-void

    .line 255
    :cond_0
    aget-object v2, v4, v5

    .line 257
    .local v2, "method":Ljava/lang/reflect/Method;
    const-class v7, Lcom/alipay/euler/andfix/annotation/MethodReplace;

    invoke-virtual {v2, v7}, Ljava/lang/reflect/Method;->getAnnotation(Ljava/lang/Class;)Ljava/lang/annotation/Annotation;

    move-result-object v3

    check-cast v3, Lcom/alipay/euler/andfix/annotation/MethodReplace;

    .line 258
    .local v3, "methodReplace":Lcom/alipay/euler/andfix/annotation/MethodReplace;
    if-nez v3, :cond_2

    .line 255
    :cond_1
    :goto_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 260
    :cond_2
    invoke-interface {v3}, Lcom/alipay/euler/andfix/annotation/MethodReplace;->clazz()Ljava/lang/String;

    move-result-object v0

    .line 261
    .local v0, "clz":Ljava/lang/String;
    invoke-interface {v3}, Lcom/alipay/euler/andfix/annotation/MethodReplace;->method()Ljava/lang/String;

    move-result-object v1

    .line 262
    .local v1, "meth":Ljava/lang/String;
    invoke-static {v0}, Lcom/alipay/euler/andfix/AndFixManager;->isEmpty(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_1

    invoke-static {v1}, Lcom/alipay/euler/andfix/AndFixManager;->isEmpty(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_1

    .line 263
    invoke-static {p1, v0, v1, v2}, Lcom/alipay/euler/andfix/AndFixManager;->replaceMethod(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Ljava/lang/reflect/Method;)V

    goto :goto_1
.end method

.method public static fixfunc(Ljava/lang/Class;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<*>;)V"
        }
    .end annotation

    .prologue
    .line 234
    .local p0, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const/4 v1, 0x0

    .line 235
    .local v1, "clazz2":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v3, "_CF"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 236
    .local v0, "className":Ljava/lang/String;
    const-string v2, "AndFixManager"

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "pacth fixfunc="

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 237
    sget-object v2, Lcom/alipay/euler/andfix/AndFixManager;->dexFile:Ldalvik/system/DexFile;

    sget-object v3, Lcom/alipay/euler/andfix/AndFixManager;->patchClassLoader:Ljava/lang/ClassLoader;

    invoke-virtual {v2, v0, v3}, Ldalvik/system/DexFile;->loadClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    .line 238
    if-eqz v1, :cond_0

    .line 239
    sget-object v2, Lcom/alipay/euler/andfix/AndFixManager;->classLoader:Ljava/lang/ClassLoader;

    invoke-static {v1, v2}, Lcom/alipay/euler/andfix/AndFixManager;->fixClass(Ljava/lang/Class;Ljava/lang/ClassLoader;)V

    .line 242
    :cond_0
    return-void
.end method

.method private static isEmpty(Ljava/lang/String;)Z
    .locals 1
    .param p0, "string"    # Ljava/lang/String;

    .prologue
    .line 298
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private static replaceMethod(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Ljava/lang/reflect/Method;)V
    .locals 7
    .param p0, "classLoader"    # Ljava/lang/ClassLoader;
    .param p1, "clz"    # Ljava/lang/String;
    .param p2, "meth"    # Ljava/lang/String;
    .param p3, "method"    # Ljava/lang/reflect/Method;

    .prologue
    .line 279
    :try_start_0
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v6, "@"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 280
    .local v3, "key":Ljava/lang/String;
    sget-object v5, Lcom/alipay/euler/andfix/AndFixManager;->mFixedClass:Ljava/util/Map;

    invoke-interface {v5, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Class;

    .line 281
    .local v0, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    if-nez v0, :cond_0

    .line 282
    invoke-virtual {p0, p1}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 284
    .local v1, "clzz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    invoke-static {v1}, Lcom/alipay/euler/andfix/AndFix;->initTargetClass(Ljava/lang/Class;)Ljava/lang/Class;

    move-result-object v0

    .line 286
    .end local v1    # "clzz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :cond_0
    if-eqz v0, :cond_1

    .line 287
    sget-object v5, Lcom/alipay/euler/andfix/AndFixManager;->mFixedClass:Ljava/util/Map;

    invoke-interface {v5, v3, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 289
    invoke-virtual {p3}, Ljava/lang/reflect/Method;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v5

    .line 288
    invoke-virtual {v0, p2, v5}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    .line 290
    .local v4, "src":Ljava/lang/reflect/Method;
    invoke-static {v4, p3}, Lcom/alipay/euler/andfix/AndFix;->addReplaceMethod(Ljava/lang/reflect/Method;Ljava/lang/reflect/Method;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 295
    .end local v0    # "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v3    # "key":Ljava/lang/String;
    .end local v4    # "src":Ljava/lang/reflect/Method;
    :cond_1
    :goto_0
    return-void

    .line 292
    :catch_0
    move-exception v2

    .line 293
    .local v2, "e":Ljava/lang/Exception;
    const-string v5, "AndFixManager"

    const-string v6, "replaceMethod"

    invoke-static {v5, v6, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method


# virtual methods
.method public declared-synchronized fix(Ljava/io/File;Ljava/lang/ClassLoader;Ljava/util/List;)V
    .locals 8
    .param p1, "file"    # Ljava/io/File;
    .param p2, "classLoader"    # Ljava/lang/ClassLoader;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/File;",
            "Ljava/lang/ClassLoader;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 126
    .local p3, "classes":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    monitor-enter p0

    :try_start_0
    iget-boolean v5, p0, Lcom/alipay/euler/andfix/AndFixManager;->mSupport:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v5, :cond_0

    .line 230
    :goto_0
    monitor-exit p0

    return-void

    .line 135
    :cond_0
    :try_start_1
    new-instance v2, Ljava/io/File;

    iget-object v5, p0, Lcom/alipay/euler/andfix/AndFixManager;->mOptDir:Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v2, v5, v6}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 136
    .local v2, "optfile":Ljava/io/File;
    const/4 v4, 0x1

    .line 137
    .local v4, "saveFingerprint":Z
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_1

    .line 143
    iget-object v5, p0, Lcom/alipay/euler/andfix/AndFixManager;->mSecurityChecker:Lcom/alipay/euler/andfix/security/SecurityChecker;

    invoke-virtual {v5, v2}, Lcom/alipay/euler/andfix/security/SecurityChecker;->verifyOpt(Ljava/io/File;)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 144
    const/4 v4, 0x0

    .line 149
    :cond_1
    const-string v5, "AndFixManager"

    const-string v6, "fix"

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 151
    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    .line 152
    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    const/4 v7, 0x0

    .line 151
    invoke-static {v5, v6, v7}, Ldalvik/system/DexFile;->loadDex(Ljava/lang/String;Ljava/lang/String;I)Ldalvik/system/DexFile;

    move-result-object v0

    .line 153
    .local v0, "dexFile":Ldalvik/system/DexFile;
    const-string v5, "AndFixManager"

    const-string v6, "pacth"

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 154
    if-eqz v4, :cond_2

    .line 155
    iget-object v5, p0, Lcom/alipay/euler/andfix/AndFixManager;->mSecurityChecker:Lcom/alipay/euler/andfix/security/SecurityChecker;

    invoke-virtual {v5, v2}, Lcom/alipay/euler/andfix/security/SecurityChecker;->saveOptSig(Ljava/io/File;)V

    .line 158
    :cond_2
    new-instance v3, Lcom/alipay/euler/andfix/AndFixManager$1;

    invoke-direct {v3, p0, p2, v0}, Lcom/alipay/euler/andfix/AndFixManager$1;-><init>(Lcom/alipay/euler/andfix/AndFixManager;Ljava/lang/ClassLoader;Ldalvik/system/DexFile;)V

    .line 175
    .local v3, "patchClassLoader":Ljava/lang/ClassLoader;
    sput-object v0, Lcom/alipay/euler/andfix/AndFixManager;->dexFile:Ldalvik/system/DexFile;

    .line 176
    sput-object v3, Lcom/alipay/euler/andfix/AndFixManager;->patchClassLoader:Ljava/lang/ClassLoader;

    .line 177
    sput-object p2, Lcom/alipay/euler/andfix/AndFixManager;->classLoader:Ljava/lang/ClassLoader;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 229
    .end local v0    # "dexFile":Ldalvik/system/DexFile;
    .end local v2    # "optfile":Ljava/io/File;
    .end local v3    # "patchClassLoader":Ljava/lang/ClassLoader;
    .end local v4    # "saveFingerprint":Z
    :goto_1
    :try_start_2
    const-string v5, "AndFixManager"

    const-string v6, "fix \u8865\u4e01\u521d\u59cb\u5316\u64cd\u4f5c\u5b8c\u6210\uff0c\u63a5\u4e0b\u6765\u662f\u52a0\u8f7d\u5230\u5355\u4e2a\u7c7b\u5c31\u4fee\u590d"

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 126
    :catchall_0
    move-exception v5

    monitor-exit p0

    throw v5

    .line 145
    .restart local v2    # "optfile":Ljava/io/File;
    .restart local v4    # "saveFingerprint":Z
    :cond_3
    :try_start_3
    invoke-virtual {v2}, Ljava/io/File;->delete()Z
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result v5

    if-nez v5, :cond_1

    goto :goto_0

    .line 226
    .end local v2    # "optfile":Ljava/io/File;
    .end local v4    # "saveFingerprint":Z
    :catch_0
    move-exception v1

    .line 227
    .local v1, "e":Ljava/io/IOException;
    :try_start_4
    const-string v5, "AndFixManager"

    const-string v6, "pacth"

    invoke-static {v5, v6, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_1
.end method

.method public declared-synchronized fix(Ljava/lang/String;)V
    .locals 3
    .param p1, "patchPath"    # Ljava/lang/String;

    .prologue
    .line 108
    monitor-enter p0

    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/alipay/euler/andfix/AndFixManager;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {p0, v0, v1, v2}, Lcom/alipay/euler/andfix/AndFixManager;->fix(Ljava/io/File;Ljava/lang/ClassLoader;Ljava/util/List;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 109
    monitor-exit p0

    return-void

    .line 108
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized removeOptFile(Ljava/io/File;)V
    .locals 4
    .param p1, "file"    # Ljava/io/File;

    .prologue
    .line 95
    monitor-enter p0

    :try_start_0
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/alipay/euler/andfix/AndFixManager;->mOptDir:Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 96
    .local v0, "optfile":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    move-result v1

    if-nez v1, :cond_0

    .line 97
    const-string v1, "AndFixManager"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v3, " delete error."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 99
    :cond_0
    monitor-exit p0

    return-void

    .line 95
    .end local v0    # "optfile":Ljava/io/File;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method
