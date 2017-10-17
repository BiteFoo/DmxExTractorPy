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

package com.euler.andfix;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

import com.alipay.euler.andfix.AndFixManager;
import com.euler.test.A;
import com.euler.test.O;

/**
 * sample activity
 * 
 * @author luohou
 * @author sanping.li@alipay.com
 * 
 */
public class MainActivity2 extends Activity {
	private static final String TAG = "euler";
	static{
		AndFixManager.fixfunc(MainActivity2.class);
		System.loadLibrary("absc");
	}
	//protected
//	protected native void onCreate(Bundle savedInstanceState) ;
//	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		 setContentView(R.layout.activity_second2);
		  
		Log.e(TAG, "MainActivity2 new O().o=" + new O().o());
	}

	@Override
	protected void onDestroy() {
		super.onDestroy(); 
	}
	public void an(){
		Log.e(TAG, "MainActivity2------- an="  );
	}

//	Button button = (Button)findViewById(R.id.but2 ); 
//	 button.setOnClickListener(new OnClickListener() { 
//	@Override
//	public void onClick(View v) {
//		Log.d(TAG, "MainActivity2 button onClick"  );
//	}
//	});

}
