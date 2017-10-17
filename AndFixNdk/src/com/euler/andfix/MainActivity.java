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

import com.euler.test.A;
import com.euler.test.O;

/**
 * sample activity
 * 
 * @author luohou
 * @author sanping.li@alipay.com
 * 
 */
public class MainActivity extends Activity {
	private static final String TAG = "euler";

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		 setContentView(R.layout.activity_second);
		 
		 Button button = (Button)findViewById(R.id.but ); 
		 button.setOnClickListener(new OnClickListener() { 
		@Override
		public void onClick(View v) {
			Log.d(TAG, "button onClick"  );
			 Intent intent = new Intent(); 
		     intent.setClass(MainActivity.this, MainActivity2.class);
		     MainActivity.this.startActivity(intent);
		}
		});
		 
		Log.e(TAG, "A.a=" + A.a("good"));
//		Log.e(TAG, "new O().o=" + new O("o").o());
		Log.e(TAG, "new A().b=" + new A().b("s1", "s2"));
		Log.e(TAG, "native="+new A().n("n"));
		Log.e(TAG, "new A().getI()=" + new A().getI());
	}

	@Override
	protected void onDestroy() {
		super.onDestroy();
		//android.os.Process.killProcess(android.os.Process.myPid());
	}


}
