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

package com.euler.test;

import com.alipay.euler.andfix.AndFixManager;

import android.util.Log;

/**
 * @author sanping.li@alipay.com
 * 
 */
public class O {
	
//	static{
//		AndFixManager.fixfunc(O.class);
//	}
	
	
	public String s = "sxx";
	
//	public O(String s) {
//		this.s = s;  
//	}
	
//	public native String o();
	public String o(){
		Log.i("euler", "0()=fix ok");
		return "o()";
	}

	@Override
	public String toString() {
		return s;
	}
}
