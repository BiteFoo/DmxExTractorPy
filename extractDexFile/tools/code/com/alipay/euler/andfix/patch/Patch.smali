.class public Lcom/alipay/euler/andfix/patch/Patch;
.super Ljava/lang/Object;
.source "Patch.java"

# interfaces
.implements Ljava/lang/Comparable;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/lang/Comparable",
        "<",
        "Lcom/alipay/euler/andfix/patch/Patch;",
        ">;"
    }
.end annotation


# static fields
.field private static final CLASSES:Ljava/lang/String; = "-Classes"

.field private static final CREATED_TIME:Ljava/lang/String; = "Created-Time"

.field private static final ENTRY_NAME:Ljava/lang/String; = "META-INF/PATCH.MF"

.field private static final PATCH_CLASSES:Ljava/lang/String; = "Patch-Classes"

.field private static final PATCH_NAME:Ljava/lang/String; = "Patch-Name"


# instance fields
.field private mClassesMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation
.end field

.field private final mFile:Ljava/io/File;

.field private mName:Ljava/lang/String;

.field private mTime:Ljava/util/Date;


# direct methods
.method public constructor <init>(Ljava/io/File;)V
    .locals 0
    .param p1, "file"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 65
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 66
    iput-object p1, p0, Lcom/alipay/euler/andfix/patch/Patch;->mFile:Ljava/io/File;

    .line 67
    invoke-direct {p0}, Lcom/alipay/euler/andfix/patch/Patch;->init()V

    .line 68
    return-void
.end method

.method private init()V
    .locals 14
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 72
    const/4 v4, 0x0

    .line 73
    .local v4, "jarFile":Ljava/util/jar/JarFile;
    const/4 v2, 0x0

    .line 75
    .local v2, "inputStream":Ljava/io/InputStream;
    :try_start_0
    new-instance v5, Ljava/util/jar/JarFile;

    iget-object v10, p0, Lcom/alipay/euler/andfix/patch/Patch;->mFile:Ljava/io/File;

    invoke-direct {v5, v10}, Ljava/util/jar/JarFile;-><init>(Ljava/io/File;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 76
    .end local v4    # "jarFile":Ljava/util/jar/JarFile;
    .local v5, "jarFile":Ljava/util/jar/JarFile;
    :try_start_1
    const-string v10, "META-INF/PATCH.MF"

    invoke-virtual {v5, v10}, Ljava/util/jar/JarFile;->getJarEntry(Ljava/lang/String;)Ljava/util/jar/JarEntry;

    move-result-object v1

    .line 77
    .local v1, "entry":Ljava/util/jar/JarEntry;
    invoke-virtual {v5, v1}, Ljava/util/jar/JarFile;->getInputStream(Ljava/util/zip/ZipEntry;)Ljava/io/InputStream;

    move-result-object v2

    .line 78
    new-instance v7, Ljava/util/jar/Manifest;

    invoke-direct {v7, v2}, Ljava/util/jar/Manifest;-><init>(Ljava/io/InputStream;)V

    .line 79
    .local v7, "manifest":Ljava/util/jar/Manifest;
    invoke-virtual {v7}, Ljava/util/jar/Manifest;->getMainAttributes()Ljava/util/jar/Attributes;

    move-result-object v6

    .line 80
    .local v6, "main":Ljava/util/jar/Attributes;
    const-string v10, "Patch-Name"

    invoke-virtual {v6, v10}, Ljava/util/jar/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    iput-object v10, p0, Lcom/alipay/euler/andfix/patch/Patch;->mName:Ljava/lang/String;

    .line 81
    new-instance v10, Ljava/util/Date;

    const-string v11, "Created-Time"

    invoke-virtual {v6, v11}, Ljava/util/jar/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    invoke-direct {v10, v11}, Ljava/util/Date;-><init>(Ljava/lang/String;)V

    iput-object v10, p0, Lcom/alipay/euler/andfix/patch/Patch;->mTime:Ljava/util/Date;

    .line 83
    new-instance v10, Ljava/util/HashMap;

    invoke-direct {v10}, Ljava/util/HashMap;-><init>()V

    iput-object v10, p0, Lcom/alipay/euler/andfix/patch/Patch;->mClassesMap:Ljava/util/Map;

    .line 87
    invoke-virtual {v6}, Ljava/util/jar/Attributes;->keySet()Ljava/util/Set;

    move-result-object v10

    invoke-interface {v10}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .local v3, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    :cond_0
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v10

    if-nez v10, :cond_3

    .line 104
    if-eqz v5, :cond_1

    .line 105
    invoke-virtual {v5}, Ljava/util/jar/JarFile;->close()V

    .line 107
    :cond_1
    if-eqz v2, :cond_2

    .line 108
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    .line 112
    :cond_2
    return-void

    .line 88
    :cond_3
    :try_start_2
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/jar/Attributes$Name;

    .line 89
    .local v0, "attrName":Ljava/util/jar/Attributes$Name;
    invoke-virtual {v0}, Ljava/util/jar/Attributes$Name;->toString()Ljava/lang/String;

    move-result-object v8

    .line 91
    .local v8, "name":Ljava/lang/String;
    const-string v10, "-Classes"

    invoke-virtual {v8, v10}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_0

    .line 92
    invoke-virtual {v6, v0}, Ljava/util/jar/Attributes;->getValue(Ljava/util/jar/Attributes$Name;)Ljava/lang/String;

    move-result-object v10

    const-string v11, ","

    invoke-virtual {v10, v11}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v9

    .line 93
    .local v9, "strings":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    const-string v10, "Patch-Classes"

    invoke-virtual {v8, v10}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_6

    .line 94
    iget-object v10, p0, Lcom/alipay/euler/andfix/patch/Patch;->mClassesMap:Ljava/util/Map;

    iget-object v11, p0, Lcom/alipay/euler/andfix/patch/Patch;->mName:Ljava/lang/String;

    invoke-interface {v10, v11, v9}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 103
    .end local v0    # "attrName":Ljava/util/jar/Attributes$Name;
    .end local v1    # "entry":Ljava/util/jar/JarEntry;
    .end local v3    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    .end local v6    # "main":Ljava/util/jar/Attributes;
    .end local v7    # "manifest":Ljava/util/jar/Manifest;
    .end local v8    # "name":Ljava/lang/String;
    .end local v9    # "strings":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    :catchall_0
    move-exception v10

    move-object v4, v5

    .line 104
    .end local v5    # "jarFile":Ljava/util/jar/JarFile;
    .restart local v4    # "jarFile":Ljava/util/jar/JarFile;
    :goto_1
    if-eqz v4, :cond_4

    .line 105
    invoke-virtual {v4}, Ljava/util/jar/JarFile;->close()V

    .line 107
    :cond_4
    if-eqz v2, :cond_5

    .line 108
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    .line 110
    :cond_5
    throw v10

    .line 96
    .end local v4    # "jarFile":Ljava/util/jar/JarFile;
    .restart local v0    # "attrName":Ljava/util/jar/Attributes$Name;
    .restart local v1    # "entry":Ljava/util/jar/JarEntry;
    .restart local v3    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    .restart local v5    # "jarFile":Ljava/util/jar/JarFile;
    .restart local v6    # "main":Ljava/util/jar/Attributes;
    .restart local v7    # "manifest":Ljava/util/jar/Manifest;
    .restart local v8    # "name":Ljava/lang/String;
    .restart local v9    # "strings":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    :cond_6
    :try_start_3
    iget-object v10, p0, Lcom/alipay/euler/andfix/patch/Patch;->mClassesMap:Ljava/util/Map;

    .line 97
    invoke-virtual {v8}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v11

    const/4 v12, 0x0

    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v13

    add-int/lit8 v13, v13, -0x8

    invoke-virtual {v11, v12, v13}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v11

    .line 96
    invoke-interface {v10, v11, v9}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    .line 103
    .end local v0    # "attrName":Ljava/util/jar/Attributes$Name;
    .end local v1    # "entry":Ljava/util/jar/JarEntry;
    .end local v3    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    .end local v5    # "jarFile":Ljava/util/jar/JarFile;
    .end local v6    # "main":Ljava/util/jar/Attributes;
    .end local v7    # "manifest":Ljava/util/jar/Manifest;
    .end local v8    # "name":Ljava/lang/String;
    .end local v9    # "strings":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    .restart local v4    # "jarFile":Ljava/util/jar/JarFile;
    :catchall_1
    move-exception v10

    goto :goto_1
.end method


# virtual methods
.method public compareTo(Lcom/alipay/euler/andfix/patch/Patch;)I
    .locals 2
    .param p1, "another"    # Lcom/alipay/euler/andfix/patch/Patch;

    .prologue
    .line 136
    iget-object v0, p0, Lcom/alipay/euler/andfix/patch/Patch;->mTime:Ljava/util/Date;

    invoke-virtual {p1}, Lcom/alipay/euler/andfix/patch/Patch;->getTime()Ljava/util/Date;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Date;->compareTo(Ljava/util/Date;)I

    move-result v0

    return v0
.end method

.method public bridge synthetic compareTo(Ljava/lang/Object;)I
    .locals 1

    .prologue
    .line 1
    check-cast p1, Lcom/alipay/euler/andfix/patch/Patch;

    invoke-virtual {p0, p1}, Lcom/alipay/euler/andfix/patch/Patch;->compareTo(Lcom/alipay/euler/andfix/patch/Patch;)I

    move-result v0

    return v0
.end method

.method public getClasses(Ljava/lang/String;)Ljava/util/List;
    .locals 1
    .param p1, "patchName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 127
    iget-object v0, p0, Lcom/alipay/euler/andfix/patch/Patch;->mClassesMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    return-object v0
.end method

.method public getFile()Ljava/io/File;
    .locals 1

    .prologue
    .line 119
    iget-object v0, p0, Lcom/alipay/euler/andfix/patch/Patch;->mFile:Ljava/io/File;

    return-object v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 115
    iget-object v0, p0, Lcom/alipay/euler/andfix/patch/Patch;->mName:Ljava/lang/String;

    return-object v0
.end method

.method public getPatchNames()Ljava/util/Set;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 123
    iget-object v0, p0, Lcom/alipay/euler/andfix/patch/Patch;->mClassesMap:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v0

    return-object v0
.end method

.method public getTime()Ljava/util/Date;
    .locals 1

    .prologue
    .line 131
    iget-object v0, p0, Lcom/alipay/euler/andfix/patch/Patch;->mTime:Ljava/util/Date;

    return-object v0
.end method
