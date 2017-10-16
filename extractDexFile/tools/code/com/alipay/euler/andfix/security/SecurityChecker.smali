.class public Lcom/alipay/euler/andfix/security/SecurityChecker;
.super Ljava/lang/Object;
.source "SecurityChecker.java"


# static fields
.field private static final CLASSES_DEX:Ljava/lang/String; = "classes.dex"

.field private static final DEBUG_DN:Ljavax/security/auth/x500/X500Principal;

.field private static final SP_MD5:Ljava/lang/String; = "-md5"

.field private static final SP_NAME:Ljava/lang/String; = "_andfix_"

.field private static final TAG:Ljava/lang/String; = "SecurityChecker"


# instance fields
.field private final mContext:Landroid/content/Context;

.field private mDebuggable:Z

.field private mPublicKey:Ljava/security/PublicKey;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 59
    new-instance v0, Ljavax/security/auth/x500/X500Principal;

    .line 60
    const-string v1, "CN=Android Debug,O=Android,C=US"

    .line 59
    invoke-direct {v0, v1}, Ljavax/security/auth/x500/X500Principal;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/alipay/euler/andfix/security/SecurityChecker;->DEBUG_DN:Ljavax/security/auth/x500/X500Principal;

    .line 60
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 72
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 73
    iput-object p1, p0, Lcom/alipay/euler/andfix/security/SecurityChecker;->mContext:Landroid/content/Context;

    .line 74
    iget-object v0, p0, Lcom/alipay/euler/andfix/security/SecurityChecker;->mContext:Landroid/content/Context;

    invoke-direct {p0, v0}, Lcom/alipay/euler/andfix/security/SecurityChecker;->init(Landroid/content/Context;)V

    .line 75
    return-void
.end method

.method private check(Ljava/io/File;[Ljava/security/cert/Certificate;)Z
    .locals 4
    .param p1, "path"    # Ljava/io/File;
    .param p2, "certs"    # [Ljava/security/cert/Certificate;

    .prologue
    .line 155
    array-length v2, p2

    if-lez v2, :cond_0

    .line 156
    array-length v2, p2

    add-int/lit8 v1, v2, -0x1

    .local v1, "i":I
    :goto_0
    if-gez v1, :cond_1

    .line 165
    .end local v1    # "i":I
    :cond_0
    const/4 v2, 0x0

    :goto_1
    return v2

    .line 158
    .restart local v1    # "i":I
    :cond_1
    :try_start_0
    aget-object v2, p2, v1

    iget-object v3, p0, Lcom/alipay/euler/andfix/security/SecurityChecker;->mPublicKey:Ljava/security/PublicKey;

    invoke-virtual {v2, v3}, Ljava/security/cert/Certificate;->verify(Ljava/security/PublicKey;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 159
    const/4 v2, 0x1

    goto :goto_1

    .line 160
    :catch_0
    move-exception v0

    .line 161
    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "SecurityChecker"

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 156
    add-int/lit8 v1, v1, -0x1

    goto :goto_0
.end method

.method private getFileMD5(Ljava/io/File;)Ljava/lang/String;
    .locals 10
    .param p1, "file"    # Ljava/io/File;

    .prologue
    const/4 v7, 0x0

    .line 169
    invoke-virtual {p1}, Ljava/io/File;->isFile()Z

    move-result v8

    if-nez v8, :cond_1

    .line 194
    :cond_0
    :goto_0
    return-object v7

    .line 172
    :cond_1
    const/4 v2, 0x0

    .line 173
    .local v2, "digest":Ljava/security/MessageDigest;
    const/4 v4, 0x0

    .line 174
    .local v4, "in":Ljava/io/FileInputStream;
    const/16 v8, 0x2000

    new-array v1, v8, [B

    .line 177
    .local v1, "buffer":[B
    :try_start_0
    const-string v8, "MD5"

    invoke-static {v8}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v2

    .line 178
    new-instance v5, Ljava/io/FileInputStream;

    invoke-direct {v5, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_4
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 179
    .end local v4    # "in":Ljava/io/FileInputStream;
    .local v5, "in":Ljava/io/FileInputStream;
    :goto_1
    :try_start_1
    invoke-virtual {v5, v1}, Ljava/io/FileInputStream;->read([B)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v6

    .local v6, "len":I
    const/4 v8, -0x1

    if-ne v6, v8, :cond_3

    .line 187
    if-eqz v5, :cond_2

    .line 188
    :try_start_2
    invoke-virtual {v5}, Ljava/io/FileInputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_3

    .line 193
    :cond_2
    :goto_2
    new-instance v0, Ljava/math/BigInteger;

    invoke-virtual {v2}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v7

    invoke-direct {v0, v7}, Ljava/math/BigInteger;-><init>([B)V

    .line 194
    .local v0, "bigInt":Ljava/math/BigInteger;
    invoke-virtual {v0}, Ljava/math/BigInteger;->toString()Ljava/lang/String;

    move-result-object v7

    goto :goto_0

    .line 180
    .end local v0    # "bigInt":Ljava/math/BigInteger;
    :cond_3
    const/4 v8, 0x0

    :try_start_3
    invoke-virtual {v2, v1, v8, v6}, Ljava/security/MessageDigest;->update([BII)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_1

    .line 182
    .end local v6    # "len":I
    :catch_0
    move-exception v3

    move-object v4, v5

    .line 183
    .end local v5    # "in":Ljava/io/FileInputStream;
    .local v3, "e":Ljava/lang/Exception;
    .restart local v4    # "in":Ljava/io/FileInputStream;
    :goto_3
    :try_start_4
    const-string v8, "SecurityChecker"

    const-string v9, "getFileMD5"

    invoke-static {v8, v9, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 187
    if-eqz v4, :cond_0

    .line 188
    :try_start_5
    invoke-virtual {v4}, Ljava/io/FileInputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_1

    goto :goto_0

    .line 189
    :catch_1
    move-exception v3

    .line 190
    .local v3, "e":Ljava/io/IOException;
    const-string v8, "SecurityChecker"

    const-string v9, "getFileMD5"

    invoke-static {v8, v9, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 185
    .end local v3    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v7

    .line 187
    :goto_4
    if-eqz v4, :cond_4

    .line 188
    :try_start_6
    invoke-virtual {v4}, Ljava/io/FileInputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_2

    .line 192
    :cond_4
    :goto_5
    throw v7

    .line 189
    :catch_2
    move-exception v3

    .line 190
    .restart local v3    # "e":Ljava/io/IOException;
    const-string v8, "SecurityChecker"

    const-string v9, "getFileMD5"

    invoke-static {v8, v9, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_5

    .line 189
    .end local v3    # "e":Ljava/io/IOException;
    .end local v4    # "in":Ljava/io/FileInputStream;
    .restart local v5    # "in":Ljava/io/FileInputStream;
    .restart local v6    # "len":I
    :catch_3
    move-exception v3

    .line 190
    .restart local v3    # "e":Ljava/io/IOException;
    const-string v7, "SecurityChecker"

    const-string v8, "getFileMD5"

    invoke-static {v7, v8, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_2

    .line 185
    .end local v3    # "e":Ljava/io/IOException;
    .end local v6    # "len":I
    :catchall_1
    move-exception v7

    move-object v4, v5

    .end local v5    # "in":Ljava/io/FileInputStream;
    .restart local v4    # "in":Ljava/io/FileInputStream;
    goto :goto_4

    .line 182
    :catch_4
    move-exception v3

    goto :goto_3
.end method

.method private getFingerprint(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "fileName"    # Ljava/lang/String;

    .prologue
    .line 207
    iget-object v1, p0, Lcom/alipay/euler/andfix/security/SecurityChecker;->mContext:Landroid/content/Context;

    .line 208
    const-string v2, "_andfix_"

    const/4 v3, 0x0

    .line 207
    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 209
    .local v0, "sharedPreferences":Landroid/content/SharedPreferences;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, "-md5"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method private init(Landroid/content/Context;)V
    .locals 9
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 216
    :try_start_0
    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v5

    .line 217
    .local v5, "pm":Landroid/content/pm/PackageManager;
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    .line 220
    .local v4, "packageName":Ljava/lang/String;
    const/16 v7, 0x40

    .line 219
    invoke-virtual {v5, v4, v7}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v3

    .line 222
    .local v3, "packageInfo":Landroid/content/pm/PackageInfo;
    const-string v7, "X.509"

    invoke-static {v7}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    move-result-object v1

    .line 223
    .local v1, "certFactory":Ljava/security/cert/CertificateFactory;
    new-instance v6, Ljava/io/ByteArrayInputStream;

    .line 224
    iget-object v7, v3, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    const/4 v8, 0x0

    aget-object v7, v7, v8

    invoke-virtual {v7}, Landroid/content/pm/Signature;->toByteArray()[B

    move-result-object v7

    .line 223
    invoke-direct {v6, v7}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 226
    .local v6, "stream":Ljava/io/ByteArrayInputStream;
    invoke-virtual {v1, v6}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    move-result-object v0

    .line 225
    check-cast v0, Ljava/security/cert/X509Certificate;

    .line 227
    .local v0, "cert":Ljava/security/cert/X509Certificate;
    invoke-virtual {v0}, Ljava/security/cert/X509Certificate;->getSubjectX500Principal()Ljavax/security/auth/x500/X500Principal;

    move-result-object v7

    sget-object v8, Lcom/alipay/euler/andfix/security/SecurityChecker;->DEBUG_DN:Ljavax/security/auth/x500/X500Principal;

    invoke-virtual {v7, v8}, Ljavax/security/auth/x500/X500Principal;->equals(Ljava/lang/Object;)Z

    move-result v7

    iput-boolean v7, p0, Lcom/alipay/euler/andfix/security/SecurityChecker;->mDebuggable:Z

    .line 228
    invoke-virtual {v0}, Ljava/security/cert/X509Certificate;->getPublicKey()Ljava/security/PublicKey;

    move-result-object v7

    iput-object v7, p0, Lcom/alipay/euler/andfix/security/SecurityChecker;->mPublicKey:Ljava/security/PublicKey;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/security/cert/CertificateException; {:try_start_0 .. :try_end_0} :catch_1

    .line 234
    .end local v0    # "cert":Ljava/security/cert/X509Certificate;
    .end local v1    # "certFactory":Ljava/security/cert/CertificateFactory;
    .end local v3    # "packageInfo":Landroid/content/pm/PackageInfo;
    .end local v4    # "packageName":Ljava/lang/String;
    .end local v5    # "pm":Landroid/content/pm/PackageManager;
    .end local v6    # "stream":Ljava/io/ByteArrayInputStream;
    :goto_0
    return-void

    .line 229
    :catch_0
    move-exception v2

    .line 230
    .local v2, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    const-string v7, "SecurityChecker"

    const-string v8, "init"

    invoke-static {v7, v8, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 231
    .end local v2    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :catch_1
    move-exception v2

    .line 232
    .local v2, "e":Ljava/security/cert/CertificateException;
    const-string v7, "SecurityChecker"

    const-string v8, "init"

    invoke-static {v7, v8, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method private loadDigestes(Ljava/util/jar/JarFile;Ljava/util/jar/JarEntry;)V
    .locals 3
    .param p1, "jarFile"    # Ljava/util/jar/JarFile;
    .param p2, "je"    # Ljava/util/jar/JarEntry;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 140
    const/4 v1, 0x0

    .line 142
    .local v1, "is":Ljava/io/InputStream;
    :try_start_0
    invoke-virtual {p1, p2}, Ljava/util/jar/JarFile;->getInputStream(Ljava/util/zip/ZipEntry;)Ljava/io/InputStream;

    move-result-object v1

    .line 143
    const/16 v2, 0x2000

    new-array v0, v2, [B

    .line 144
    .local v0, "bytes":[B
    :cond_0
    invoke-virtual {v1, v0}, Ljava/io/InputStream;->read([B)I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v2

    if-gtz v2, :cond_0

    .line 147
    if-eqz v1, :cond_1

    .line 148
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    .line 151
    :cond_1
    return-void

    .line 146
    .end local v0    # "bytes":[B
    :catchall_0
    move-exception v2

    .line 147
    if-eqz v1, :cond_2

    .line 148
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    .line 150
    :cond_2
    throw v2
.end method

.method private saveFingerprint(Ljava/lang/String;Ljava/lang/String;)V
    .locals 5
    .param p1, "fileName"    # Ljava/lang/String;
    .param p2, "md5"    # Ljava/lang/String;

    .prologue
    .line 199
    iget-object v2, p0, Lcom/alipay/euler/andfix/security/SecurityChecker;->mContext:Landroid/content/Context;

    .line 200
    const-string v3, "_andfix_"

    const/4 v4, 0x0

    .line 199
    invoke-virtual {v2, v3, v4}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 201
    .local v1, "sharedPreferences":Landroid/content/SharedPreferences;
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 202
    .local v0, "editor":Landroid/content/SharedPreferences$Editor;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v3, "-md5"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v2, p2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 203
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 204
    return-void
.end method


# virtual methods
.method public saveOptSig(Ljava/io/File;)V
    .locals 2
    .param p1, "file"    # Ljava/io/File;

    .prologue
    .line 96
    invoke-direct {p0, p1}, Lcom/alipay/euler/andfix/security/SecurityChecker;->getFileMD5(Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    .line 97
    .local v0, "fingerprint":Ljava/lang/String;
    invoke-virtual {p1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1, v0}, Lcom/alipay/euler/andfix/security/SecurityChecker;->saveFingerprint(Ljava/lang/String;Ljava/lang/String;)V

    .line 98
    return-void
.end method

.method public verifyApk(Ljava/io/File;)Z
    .locals 8
    .param p1, "path"    # Ljava/io/File;

    .prologue
    const/4 v5, 0x0

    .line 106
    iget-boolean v6, p0, Lcom/alipay/euler/andfix/security/SecurityChecker;->mDebuggable:Z

    if-eqz v6, :cond_1

    .line 107
    const-string v5, "SecurityChecker"

    const-string v6, "mDebuggable = true"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 108
    const/4 v5, 0x1

    .line 127
    :cond_0
    :goto_0
    return v5

    .line 111
    :cond_1
    const/4 v3, 0x0

    .line 113
    .local v3, "jarFile":Ljava/util/jar/JarFile;
    :try_start_0
    new-instance v4, Ljava/util/jar/JarFile;

    invoke-direct {v4, p1}, Ljava/util/jar/JarFile;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_3
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 115
    .end local v3    # "jarFile":Ljava/util/jar/JarFile;
    .local v4, "jarFile":Ljava/util/jar/JarFile;
    :try_start_1
    const-string v6, "classes.dex"

    invoke-virtual {v4, v6}, Ljava/util/jar/JarFile;->getJarEntry(Ljava/lang/String;)Ljava/util/jar/JarEntry;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result-object v2

    .line 116
    .local v2, "jarEntry":Ljava/util/jar/JarEntry;
    if-nez v2, :cond_2

    .line 130
    if-eqz v4, :cond_0

    .line 131
    :try_start_2
    invoke-virtual {v4}, Ljava/util/jar/JarFile;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 133
    :catch_0
    move-exception v1

    .line 134
    .local v1, "e":Ljava/io/IOException;
    const-string v6, "SecurityChecker"

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 119
    .end local v1    # "e":Ljava/io/IOException;
    :cond_2
    :try_start_3
    invoke-direct {p0, v4, v2}, Lcom/alipay/euler/andfix/security/SecurityChecker;->loadDigestes(Ljava/util/jar/JarFile;Ljava/util/jar/JarEntry;)V

    .line 120
    invoke-virtual {v2}, Ljava/util/jar/JarEntry;->getCertificates()[Ljava/security/cert/Certificate;
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_6
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    move-result-object v0

    .line 121
    .local v0, "certs":[Ljava/security/cert/Certificate;
    if-nez v0, :cond_3

    .line 130
    if-eqz v4, :cond_0

    .line 131
    :try_start_4
    invoke-virtual {v4}, Ljava/util/jar/JarFile;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1

    goto :goto_0

    .line 133
    :catch_1
    move-exception v1

    .line 134
    .restart local v1    # "e":Ljava/io/IOException;
    const-string v6, "SecurityChecker"

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 124
    .end local v1    # "e":Ljava/io/IOException;
    :cond_3
    :try_start_5
    invoke-direct {p0, p1, v0}, Lcom/alipay/euler/andfix/security/SecurityChecker;->check(Ljava/io/File;[Ljava/security/cert/Certificate;)Z
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_6
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    move-result v5

    .line 130
    if-eqz v4, :cond_0

    .line 131
    :try_start_6
    invoke-virtual {v4}, Ljava/util/jar/JarFile;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_2

    goto :goto_0

    .line 133
    :catch_2
    move-exception v1

    .line 134
    .restart local v1    # "e":Ljava/io/IOException;
    const-string v6, "SecurityChecker"

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 125
    .end local v0    # "certs":[Ljava/security/cert/Certificate;
    .end local v1    # "e":Ljava/io/IOException;
    .end local v2    # "jarEntry":Ljava/util/jar/JarEntry;
    .end local v4    # "jarFile":Ljava/util/jar/JarFile;
    .restart local v3    # "jarFile":Ljava/util/jar/JarFile;
    :catch_3
    move-exception v1

    .line 126
    .restart local v1    # "e":Ljava/io/IOException;
    :goto_1
    :try_start_7
    const-string v6, "SecurityChecker"

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 130
    if-eqz v3, :cond_0

    .line 131
    :try_start_8
    invoke-virtual {v3}, Ljava/util/jar/JarFile;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_4

    goto :goto_0

    .line 133
    :catch_4
    move-exception v1

    .line 134
    const-string v6, "SecurityChecker"

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 128
    .end local v1    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v5

    .line 130
    :goto_2
    if-eqz v3, :cond_4

    .line 131
    :try_start_9
    invoke-virtual {v3}, Ljava/util/jar/JarFile;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_5

    .line 136
    :cond_4
    :goto_3
    throw v5

    .line 133
    :catch_5
    move-exception v1

    .line 134
    .restart local v1    # "e":Ljava/io/IOException;
    const-string v6, "SecurityChecker"

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_3

    .line 128
    .end local v1    # "e":Ljava/io/IOException;
    .end local v3    # "jarFile":Ljava/util/jar/JarFile;
    .restart local v4    # "jarFile":Ljava/util/jar/JarFile;
    :catchall_1
    move-exception v5

    move-object v3, v4

    .end local v4    # "jarFile":Ljava/util/jar/JarFile;
    .restart local v3    # "jarFile":Ljava/util/jar/JarFile;
    goto :goto_2

    .line 125
    .end local v3    # "jarFile":Ljava/util/jar/JarFile;
    .restart local v4    # "jarFile":Ljava/util/jar/JarFile;
    :catch_6
    move-exception v1

    move-object v3, v4

    .end local v4    # "jarFile":Ljava/util/jar/JarFile;
    .restart local v3    # "jarFile":Ljava/util/jar/JarFile;
    goto :goto_1
.end method

.method public verifyOpt(Ljava/io/File;)Z
    .locals 3
    .param p1, "file"    # Ljava/io/File;

    .prologue
    .line 83
    invoke-direct {p0, p1}, Lcom/alipay/euler/andfix/security/SecurityChecker;->getFileMD5(Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    .line 84
    .local v0, "fingerprint":Ljava/lang/String;
    invoke-virtual {p1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/alipay/euler/andfix/security/SecurityChecker;->getFingerprint(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 85
    .local v1, "saved":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-static {v0, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 86
    const/4 v2, 0x1

    .line 88
    :goto_0
    return v2

    :cond_0
    const/4 v2, 0x0

    goto :goto_0
.end method
