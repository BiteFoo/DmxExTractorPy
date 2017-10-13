记录类抽取工程包


打差分包过程

可以先进入

java -jar .\apkpatch-1.0.3.jar -f .\sign_new.apk -t .\sign_old.apk -o patch -k release.keystore -p testres -a testres -e testres

signature目录签名apk。然后再执行打包命令


1.使用ali andfix测试类抽取过程

如何实现方法对比和实现差异打包过程

如何将差异化的方法完成修补

