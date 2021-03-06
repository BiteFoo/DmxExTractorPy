/*
 * 
 * Copyright (c) 2015, alipay.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.alipay.euler.andfix;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import android.content.Context;
import android.util.Log;

import com.alipay.euler.andfix.annotation.MethodReplace;
import com.alipay.euler.andfix.security.SecurityChecker;

import dalvik.system.DexFile;

/**
 * AndFix Manager
 * 
 * @author sanping.li@alipay.com
 * 
 */
public class AndFixManager {
	private static final String TAG = "AndFixManager";

	private static final String DIR = "apatch_opt";

	/**
	 * context
	 */
	private final Context mContext;

	/**
	 * classes will be fixed
	 */
	private static Map<String, Class<?>> mFixedClass = new ConcurrentHashMap<String, Class<?>>();

	/**
	 * whether support AndFix
	 */
	private boolean mSupport = false;

	/**
	 * security check
	 */
	private SecurityChecker mSecurityChecker;

	/**
	 * optimize directory
	 */
	private File mOptDir;

	public AndFixManager(Context context) {
		mContext = context;
		mSupport = Compat.isSupport();//判断Android机型是否适支持AndFix
		if (mSupport) {
			mSecurityChecker = new SecurityChecker(mContext);//初始化签名判断类
			mOptDir = new File(mContext.getFilesDir(), DIR);//初始化patch文件存放的文件夹 apatch_opt
			if (!mOptDir.exists() && !mOptDir.mkdirs()) {// make directory fail
				mSupport = false;
				Log.e(TAG, "opt dir create error.");
			} else if (!mOptDir.isDirectory()) {// not directory
				mOptDir.delete();//如果不是文件目录就删除
				mSupport = false;
			}
		}
	}

	/**
	 * delete optimize file of patch file
	 * 
	 * @param file
	 *            patch file
	 */
	public synchronized void removeOptFile(File file) {
		File optfile = new File(mOptDir, file.getName());
		if (optfile.exists() && !optfile.delete()) {
			Log.e(TAG, optfile.getName() + " delete error.");
		}
	}

	/**
	 * fix
	 * 
	 * @param patchPath
	 *            patch path
	 */
	public synchronized void fix(String patchPath) {
		fix(new File(patchPath), mContext.getClassLoader(), null);
	}
//	static AndFixEntity andFixEntity = new AndFixEntity();
	static public DexFile dexFile;
	static public ClassLoader classLoader;
	static public ClassLoader patchClassLoader;
	/**
	 * fix
	 * 
	 * @param file
	 *            patch file
	 * @param classLoader
	 *            classloader of class that will be fixed
	 * @param classes
	 *            classes will be fixed
	 */
	public synchronized void fix(File file, ClassLoader classLoader,
			List<String> classes) {
		if (!mSupport) {
			return;
		}
		//判断patch文件的签名校验 加固这里不需要签名校验
//		if (!mSecurityChecker.verifyApk(file)) {// security check fail
//			return;
//		}

		try {
			File optfile = new File(mOptDir, file.getName());
			boolean saveFingerprint = true;
			if (optfile.exists()) {
				// need to verify fingerprint when the optimize file exist,
				// prevent someone attack on jailbreak device with
				// Vulnerability-Parasyte.
				// btw:exaggerated android Vulnerability-Parasyte
				// http://secauo.com/Exaggerated-Android-Vulnerability-Parasyte.html 
				if (mSecurityChecker.verifyOpt(optfile)) { 
					saveFingerprint = false;
				} else if (!optfile.delete()) {
					return;
				}
			}
			Log.e(TAG, "fix");
			//加载patch文件中的dex
			final DexFile dexFile = DexFile.loadDex(file.getAbsolutePath(),
					optfile.getAbsolutePath(), Context.MODE_PRIVATE);
			Log.e(TAG, "pacth");
			if (saveFingerprint) {
				mSecurityChecker.saveOptSig(optfile);
			}
			
			ClassLoader patchClassLoader = new ClassLoader(classLoader) {
				@Override
				protected Class<?> findClass(String className)
						throws ClassNotFoundException {//重写ClasLoader的findClass方法
					Class<?> clazz = dexFile.loadClass(className, this);
					Log.e(TAG, "fix findClass="+ clazz);
					if (clazz == null
							&& className.startsWith("com.alipay.euler.andfix")) {
						return Class.forName(className);// annotation’s class
														// not found
					}
					if (clazz == null) {
						throw new ClassNotFoundException(className);
					}
					return clazz;
				}
			};
			this.dexFile = dexFile;
			this.patchClassLoader = patchClassLoader;
			this.classLoader = classLoader;
		 
//			andFixEntity.dexFile = dexFile;
//			andFixEntity.patchClassLoader = patchClassLoader;
//			andFixEntity.classLoader = classLoader;
//			AndFixHelper.andFixEntity = andFixEntity;
			  
			 /*
			Enumeration<String> entrys = dexFile.entries();
			Class<?> clazz = null;
			while (entrys.hasMoreElements()) {
				String entry = entrys.nextElement();
//				String entry="com.euler.test.O_CF";
				Log.e(TAG, "pacth entry="+ entry);
				if (classes != null && !classes.contains(entry)) {
					continue;// skip, not need fix
				}else{
					clazz = dexFile.loadClass(entry, patchClassLoader);//获取有bug的类文件
					if (clazz != null) {
						fixClass(clazz, classLoader);
					}
				}
			}
			*/	 
				/*
				Class<?> clazz2 = null;
//				while (entrys.hasMoreElements()) {
//					String entry = entrys.nextElement();
					String entry2="com.euler.test.A_CF";
					Log.e(TAG, "pacth entry="+ entry2);
					 
						clazz2 = andFixEntity.dexFile.loadClass(entry2, andFixEntity.patchClassLoader);//获取有bug的类文件
						if (clazz2 != null) {
							fixClass(clazz2, andFixEntity.classLoader);
						}
					 
					
					Class<?> clazz3 = null;
//					while (entrys.hasMoreElements()) {
//						String entry = entrys.nextElement();
						String entry3="com.euler.test.O_CF";
						Log.e(TAG, "pacth entry="+ entry3);
 
							clazz3 = andFixEntity.dexFile.loadClass(entry3, andFixEntity.patchClassLoader);//获取有bug的类文件
							if (clazz3 != null) {
								fixClass(clazz3, andFixEntity.classLoader);
							}
						 */
					 
		} catch (IOException e) {
			Log.e(TAG, "pacth", e);
		}
		Log.e(TAG, "fix 补丁初始化操作完成，接下来是加载到单个类就修复" );
	}
	
	public static void fixfunc(Class<?> clazz){
		 
		Class<?> clazz2 = null; 
			String className=clazz.getName()+"_CF";
			Log.e(TAG, "pacth fixfunc="+ className); 
				clazz2 = dexFile.loadClass(className, patchClassLoader);//获取有bug的类文件
				if (clazz2 != null) {
					fixClass(clazz2, classLoader);
				}
			 
	 }

	/**
	 * fix class
	 * 
	 * @param clazz
	 *            class
	 */
	private static void fixClass(Class<?> clazz, ClassLoader classLoader) {
		Method[] methods = clazz.getDeclaredMethods();
		MethodReplace methodReplace;
		String clz;
		String meth;
		for (Method method : methods) {
			//获取此方法的注解，因为有bug的方法在生成的patch的类中的方法都是有注解的，下面会给图进行展示
			methodReplace = method.getAnnotation(MethodReplace.class);
			if (methodReplace == null)
				continue;
			clz = methodReplace.clazz();//获取注解中clazz的值
			meth = methodReplace.method();//获取注解中method的值
			if (!isEmpty(clz) && !isEmpty(meth)) {
				replaceMethod(classLoader, clz, meth, method);
			}
		}
	}

	/**
	 * replace method
	 * 
	 * @param classLoader classloader
	 * @param clz class
	 * @param meth name of target method 
	 * @param method source method
	 */
	private static void replaceMethod(ClassLoader classLoader, String clz,
			String meth, Method method) {
		try {
			String key = clz + "@" + classLoader.toString();
			Class<?> clazz = mFixedClass.get(key);//判断此类是否被fix
			if (clazz == null) {// class not load
				Class<?> clzz = classLoader.loadClass(clz);
				// initialize target class
				clazz = AndFix.initTargetClass(clzz);//初始化class
			}
			if (clazz != null) {// initialize class OK
				mFixedClass.put(key, clazz);
				Method src = clazz.getDeclaredMethod(meth,
						method.getParameterTypes());//根据反射获取到有bug的类的方法(有bug的apk)
				AndFix.addReplaceMethod(src, method);//src是有bug的方法，method是补丁方法
			}
		} catch (Exception e) {
			Log.e(TAG, "replaceMethod", e);
		}
	}

	private static boolean isEmpty(String string) {
		return string == null || string.length() <= 0;
	}

}
