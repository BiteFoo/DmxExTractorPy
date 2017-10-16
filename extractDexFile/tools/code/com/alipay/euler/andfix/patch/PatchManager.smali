.class public Lcom/alipay/euler/andfix/patch/PatchManager;
.super Ljava/lang/Object;
.source "PatchManager.java"


# static fields
.field private static final DIR:Ljava/lang/String; = "apatch"

.field private static final SP_NAME:Ljava/lang/String; = "_andfix_"

.field private static final SP_VERSION:Ljava/lang/String; = "version"

.field private static final SUFFIX:Ljava/lang/String; = ".apatch"

.field private static final TAG:Ljava/lang/String; = "PatchManager"


# instance fields
.field private final mAndFixManager:Lcom/alipay/euler/andfix/AndFixManager;

.field private final mContext:Landroid/content/Context;

.field private final mLoaders:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/ClassLoader;",
            ">;"
        }
    .end annotation
.end field

.field private final mPatchDir:Ljava/io/File;

.field private final mPatchs:Ljava/util/SortedSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/SortedSet",
            "<",
            "Lcom/alipay/euler/andfix/patch/Patch;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    .prologue
    .line 78
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 79
    iput-object p1, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mContext:Landroid/content/Context;

    .line 80
    new-instance v0, Lcom/alipay/euler/andfix/AndFixManager;

    iget-object v1, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/alipay/euler/andfix/AndFixManager;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mAndFixManager:Lcom/alipay/euler/andfix/AndFixManager;

    .line 81
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "apatch"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mPatchDir:Ljava/io/File;

    .line 82
    const-string v0, "PatchManager"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "PatchManager mPatchDir="

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mPatchDir:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 83
    new-instance v0, Ljava/util/concurrent/ConcurrentSkipListSet;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentSkipListSet;-><init>()V

    iput-object v0, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mPatchs:Ljava/util/SortedSet;

    .line 84
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mLoaders:Ljava/util/Map;

    .line 85
    return-void
.end method

.method private addPatch(Ljava/io/File;)Lcom/alipay/euler/andfix/patch/Patch;
    .locals 5
    .param p1, "file"    # Ljava/io/File;

    .prologue
    .line 129
    const/4 v1, 0x0

    .line 130
    .local v1, "patch":Lcom/alipay/euler/andfix/patch/Patch;
    invoke-virtual {p1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v3

    const-string v4, ".apatch"

    invoke-virtual {v3, v4}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 132
    :try_start_0
    new-instance v2, Lcom/alipay/euler/andfix/patch/Patch;

    invoke-direct {v2, p1}, Lcom/alipay/euler/andfix/patch/Patch;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 133
    .end local v1    # "patch":Lcom/alipay/euler/andfix/patch/Patch;
    .local v2, "patch":Lcom/alipay/euler/andfix/patch/Patch;
    :try_start_1
    const-string v3, "PatchManager"

    const-string v4, "addPatch \u5b9e\u4f8b\u5316Patch\u5bf9\u8c61\u5b8c\u6210"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 134
    iget-object v3, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mPatchs:Ljava/util/SortedSet;

    invoke-interface {v3, v2}, Ljava/util/SortedSet;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    move-object v1, v2

    .line 139
    .end local v2    # "patch":Lcom/alipay/euler/andfix/patch/Patch;
    .restart local v1    # "patch":Lcom/alipay/euler/andfix/patch/Patch;
    :cond_0
    :goto_0
    return-object v1

    .line 135
    :catch_0
    move-exception v0

    .line 136
    .local v0, "e":Ljava/io/IOException;
    :goto_1
    const-string v3, "PatchManager"

    const-string v4, "addPatch"

    invoke-static {v3, v4, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 135
    .end local v0    # "e":Ljava/io/IOException;
    .end local v1    # "patch":Lcom/alipay/euler/andfix/patch/Patch;
    .restart local v2    # "patch":Lcom/alipay/euler/andfix/patch/Patch;
    :catch_1
    move-exception v0

    move-object v1, v2

    .end local v2    # "patch":Lcom/alipay/euler/andfix/patch/Patch;
    .restart local v1    # "patch":Lcom/alipay/euler/andfix/patch/Patch;
    goto :goto_1
.end method

.method private cleanPatch()V
    .locals 7

    .prologue
    .line 143
    iget-object v2, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mPatchDir:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    .line 144
    .local v1, "files":[Ljava/io/File;
    array-length v3, v1

    const/4 v2, 0x0

    :goto_0
    if-lt v2, v3, :cond_0

    .line 150
    return-void

    .line 144
    :cond_0
    aget-object v0, v1, v2

    .line 145
    .local v0, "file":Ljava/io/File;
    iget-object v4, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mAndFixManager:Lcom/alipay/euler/andfix/AndFixManager;

    invoke-virtual {v4, v0}, Lcom/alipay/euler/andfix/AndFixManager;->removeOptFile(Ljava/io/File;)V

    .line 146
    invoke-static {v0}, Lcom/alipay/euler/andfix/util/FileUtil;->deleteFile(Ljava/io/File;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 147
    const-string v4, "PatchManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v6, " delete error."

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 144
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0
.end method

.method private initPatchs()V
    .locals 7

    .prologue
    .line 114
    iget-object v2, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mPatchDir:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    .line 115
    .local v1, "files":[Ljava/io/File;
    const-string v2, "PatchManager"

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "initPatchs files.length="

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    array-length v4, v1

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 116
    array-length v3, v1

    const/4 v2, 0x0

    :goto_0
    if-lt v2, v3, :cond_0

    .line 120
    return-void

    .line 116
    :cond_0
    aget-object v0, v1, v2

    .line 117
    .local v0, "file":Ljava/io/File;
    const-string v4, "PatchManager"

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "initPatchs file name="

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 118
    invoke-direct {p0, v0}, Lcom/alipay/euler/andfix/patch/PatchManager;->addPatch(Ljava/io/File;)Lcom/alipay/euler/andfix/patch/Patch;

    .line 116
    add-int/lit8 v2, v2, 0x1

    goto :goto_0
.end method

.method private loadPatch(Lcom/alipay/euler/andfix/patch/Patch;)V
    .locals 8
    .param p1, "patch"    # Lcom/alipay/euler/andfix/patch/Patch;

    .prologue
    .line 234
    invoke-virtual {p1}, Lcom/alipay/euler/andfix/patch/Patch;->getPatchNames()Ljava/util/Set;

    move-result-object v3

    .line 237
    .local v3, "patchNames":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_0
    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-nez v5, :cond_1

    .line 251
    return-void

    .line 237
    :cond_1
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 238
    .local v2, "patchName":Ljava/lang/String;
    const-string v5, "PatchManager"

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "loadPatch  patchName="

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 239
    iget-object v5, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mLoaders:Ljava/util/Map;

    const-string v6, "*"

    invoke-interface {v5, v6}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 240
    iget-object v5, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    .line 244
    .local v0, "cl":Ljava/lang/ClassLoader;
    :goto_1
    if-eqz v0, :cond_0

    .line 245
    invoke-virtual {p1, v2}, Lcom/alipay/euler/andfix/patch/Patch;->getClasses(Ljava/lang/String;)Ljava/util/List;

    move-result-object v1

    .line 246
    .local v1, "classes":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    const-string v5, "PatchManager"

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "loadPatch  mAndFixManager.fix(patch.getFile(), cl, classes) size="

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 247
    iget-object v5, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mAndFixManager:Lcom/alipay/euler/andfix/AndFixManager;

    invoke-virtual {p1}, Lcom/alipay/euler/andfix/patch/Patch;->getFile()Ljava/io/File;

    move-result-object v6

    invoke-virtual {v5, v6, v0, v1}, Lcom/alipay/euler/andfix/AndFixManager;->fix(Ljava/io/File;Ljava/lang/ClassLoader;Ljava/util/List;)V

    .line 248
    const-string v5, "PatchManager"

    const-string v6, "loadPatch  mAndFixManager.fix(patch.getFile(), cl, classes); sucess"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 242
    .end local v0    # "cl":Ljava/lang/ClassLoader;
    .end local v1    # "classes":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    :cond_2
    iget-object v5, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mLoaders:Ljava/util/Map;

    invoke-interface {v5, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ClassLoader;

    .restart local v0    # "cl":Ljava/lang/ClassLoader;
    goto :goto_1
.end method


# virtual methods
.method public addPatch(Ljava/lang/String;)V
    .locals 6
    .param p1, "path"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 160
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 161
    .local v2, "src":Ljava/io/File;
    new-instance v0, Ljava/io/File;

    iget-object v3, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mPatchDir:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v0, v3, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 162
    .local v0, "dest":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_0

    .line 163
    new-instance v3, Ljava/io/FileNotFoundException;

    invoke-direct {v3, p1}, Ljava/io/FileNotFoundException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 165
    :cond_0
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 166
    const-string v3, "PatchManager"

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "patch ["

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "] has be loaded."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 174
    :cond_1
    :goto_0
    return-void

    .line 169
    :cond_2
    invoke-static {v2, v0}, Lcom/alipay/euler/andfix/util/FileUtil;->copyFile(Ljava/io/File;Ljava/io/File;)V

    .line 170
    invoke-direct {p0, v0}, Lcom/alipay/euler/andfix/patch/PatchManager;->addPatch(Ljava/io/File;)Lcom/alipay/euler/andfix/patch/Patch;

    move-result-object v1

    .line 171
    .local v1, "patch":Lcom/alipay/euler/andfix/patch/Patch;
    if-eqz v1, :cond_1

    .line 172
    invoke-direct {p0, v1}, Lcom/alipay/euler/andfix/patch/PatchManager;->loadPatch(Lcom/alipay/euler/andfix/patch/Patch;)V

    goto :goto_0
.end method

.method public init(Ljava/lang/String;)V
    .locals 5
    .param p1, "appVersion"    # Ljava/lang/String;

    .prologue
    .line 94
    iget-object v2, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mPatchDir:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mPatchDir:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    move-result v2

    if-nez v2, :cond_0

    .line 95
    const-string v2, "PatchManager"

    const-string v3, "patch dir create error."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 111
    :goto_0
    return-void

    .line 97
    :cond_0
    iget-object v2, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mPatchDir:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->isDirectory()Z

    move-result v2

    if-nez v2, :cond_1

    .line 98
    iget-object v2, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mPatchDir:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    goto :goto_0

    .line 101
    :cond_1
    iget-object v2, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mContext:Landroid/content/Context;

    const-string v3, "_andfix_"

    .line 102
    const/4 v4, 0x0

    .line 101
    invoke-virtual {v2, v3, v4}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 104
    .local v0, "sp":Landroid/content/SharedPreferences;
    const-string v2, "version"

    const/4 v3, 0x0

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 105
    .local v1, "ver":Ljava/lang/String;
    if-eqz v1, :cond_2

    invoke-virtual {v1, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_3

    .line 106
    :cond_2
    invoke-direct {p0}, Lcom/alipay/euler/andfix/patch/PatchManager;->cleanPatch()V

    .line 107
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    const-string v3, "version"

    invoke-interface {v2, v3, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->commit()Z

    goto :goto_0

    .line 109
    :cond_3
    invoke-direct {p0}, Lcom/alipay/euler/andfix/patch/PatchManager;->initPatchs()V

    goto :goto_0
.end method

.method public loadPatch()V
    .locals 9

    .prologue
    .line 214
    iget-object v4, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mLoaders:Ljava/util/Map;

    const-string v5, "*"

    iget-object v6, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mContext:Landroid/content/Context;

    invoke-virtual {v6}, Landroid/content/Context;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v6

    invoke-interface {v4, v5, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 217
    iget-object v4, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mPatchs:Ljava/util/SortedSet;

    invoke-interface {v4}, Ljava/util/SortedSet;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-nez v5, :cond_1

    .line 225
    return-void

    .line 217
    :cond_1
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alipay/euler/andfix/patch/Patch;

    .line 218
    .local v1, "patch":Lcom/alipay/euler/andfix/patch/Patch;
    invoke-virtual {v1}, Lcom/alipay/euler/andfix/patch/Patch;->getPatchNames()Ljava/util/Set;

    move-result-object v3

    .line 219
    .local v3, "patchNames":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 220
    .local v2, "patchName":Ljava/lang/String;
    invoke-virtual {v1, v2}, Lcom/alipay/euler/andfix/patch/Patch;->getClasses(Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    .line 221
    .local v0, "classes":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iget-object v6, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mAndFixManager:Lcom/alipay/euler/andfix/AndFixManager;

    invoke-virtual {v1}, Lcom/alipay/euler/andfix/patch/Patch;->getFile()Ljava/io/File;

    move-result-object v7

    iget-object v8, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mContext:Landroid/content/Context;

    invoke-virtual {v8}, Landroid/content/Context;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v8

    invoke-virtual {v6, v7, v8, v0}, Lcom/alipay/euler/andfix/AndFixManager;->fix(Ljava/io/File;Ljava/lang/ClassLoader;Ljava/util/List;)V

    goto :goto_0
.end method

.method public loadPatch(Ljava/lang/String;Ljava/lang/ClassLoader;)V
    .locals 6
    .param p1, "patchName"    # Ljava/lang/String;
    .param p2, "classLoader"    # Ljava/lang/ClassLoader;

    .prologue
    .line 197
    iget-object v3, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mLoaders:Ljava/util/Map;

    invoke-interface {v3, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 200
    iget-object v3, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mPatchs:Ljava/util/SortedSet;

    invoke-interface {v3}, Ljava/util/SortedSet;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_0
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-nez v4, :cond_1

    .line 207
    return-void

    .line 200
    :cond_1
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alipay/euler/andfix/patch/Patch;

    .line 201
    .local v1, "patch":Lcom/alipay/euler/andfix/patch/Patch;
    invoke-virtual {v1}, Lcom/alipay/euler/andfix/patch/Patch;->getPatchNames()Ljava/util/Set;

    move-result-object v2

    .line 202
    .local v2, "patchNames":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    invoke-interface {v2, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 203
    invoke-virtual {v1, p1}, Lcom/alipay/euler/andfix/patch/Patch;->getClasses(Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    .line 204
    .local v0, "classes":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iget-object v4, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mAndFixManager:Lcom/alipay/euler/andfix/AndFixManager;

    invoke-virtual {v1}, Lcom/alipay/euler/andfix/patch/Patch;->getFile()Ljava/io/File;

    move-result-object v5

    invoke-virtual {v4, v5, p2, v0}, Lcom/alipay/euler/andfix/AndFixManager;->fix(Ljava/io/File;Ljava/lang/ClassLoader;Ljava/util/List;)V

    goto :goto_0
.end method

.method public removeAllPatch()V
    .locals 4

    .prologue
    .line 180
    invoke-direct {p0}, Lcom/alipay/euler/andfix/patch/PatchManager;->cleanPatch()V

    .line 181
    iget-object v1, p0, Lcom/alipay/euler/andfix/patch/PatchManager;->mContext:Landroid/content/Context;

    const-string v2, "_andfix_"

    .line 182
    const/4 v3, 0x0

    .line 181
    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 183
    .local v0, "sp":Landroid/content/SharedPreferences;
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->clear()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 184
    return-void
.end method
