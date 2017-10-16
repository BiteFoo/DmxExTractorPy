.class public Lcom/alipay/euler/andfix/util/FileUtil;
.super Ljava/lang/Object;
.source "FileUtil.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static copyFile(Ljava/io/File;Ljava/io/File;)V
    .locals 7
    .param p0, "src"    # Ljava/io/File;
    .param p1, "dest"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 45
    const/4 v1, 0x0

    .line 46
    .local v1, "inChannel":Ljava/nio/channels/FileChannel;
    const/4 v6, 0x0

    .line 48
    .local v6, "outChannel":Ljava/nio/channels/FileChannel;
    :try_start_0
    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    .line 49
    invoke-virtual {p1}, Ljava/io/File;->createNewFile()Z

    .line 51
    :cond_0
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-virtual {v0}, Ljava/io/FileInputStream;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v1

    .line 52
    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v6

    .line 53
    const-wide/16 v2, 0x0

    invoke-virtual {v1}, Ljava/nio/channels/FileChannel;->size()J

    move-result-wide v4

    invoke-virtual/range {v1 .. v6}, Ljava/nio/channels/FileChannel;->transferTo(JJLjava/nio/channels/WritableByteChannel;)J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 55
    if-eqz v1, :cond_1

    .line 56
    invoke-virtual {v1}, Ljava/nio/channels/FileChannel;->close()V

    .line 58
    :cond_1
    if-eqz v6, :cond_2

    .line 59
    invoke-virtual {v6}, Ljava/nio/channels/FileChannel;->close()V

    .line 62
    :cond_2
    return-void

    .line 54
    :catchall_0
    move-exception v0

    .line 55
    if-eqz v1, :cond_3

    .line 56
    invoke-virtual {v1}, Ljava/nio/channels/FileChannel;->close()V

    .line 58
    :cond_3
    if-eqz v6, :cond_4

    .line 59
    invoke-virtual {v6}, Ljava/nio/channels/FileChannel;->close()V

    .line 61
    :cond_4
    throw v0
.end method

.method public static deleteFile(Ljava/io/File;)Z
    .locals 4
    .param p0, "file"    # Ljava/io/File;

    .prologue
    .line 72
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_0

    .line 73
    const/4 v2, 0x1

    .line 81
    :goto_0
    return v2

    .line 75
    :cond_0
    invoke-virtual {p0}, Ljava/io/File;->isDirectory()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 76
    invoke-virtual {p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    .line 77
    .local v1, "files":[Ljava/io/File;
    array-length v3, v1

    const/4 v2, 0x0

    :goto_1
    if-lt v2, v3, :cond_2

    .line 81
    .end local v1    # "files":[Ljava/io/File;
    :cond_1
    invoke-virtual {p0}, Ljava/io/File;->delete()Z

    move-result v2

    goto :goto_0

    .line 77
    .restart local v1    # "files":[Ljava/io/File;
    :cond_2
    aget-object v0, v1, v2

    .line 78
    .local v0, "f":Ljava/io/File;
    invoke-static {v0}, Lcom/alipay/euler/andfix/util/FileUtil;->deleteFile(Ljava/io/File;)Z

    .line 77
    add-int/lit8 v2, v2, 0x1

    goto :goto_1
.end method
