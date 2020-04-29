import android.app.Activity;
import android.content.Context;
import android.widget.FrameLayout;
import android.view.ViewParent;
import android.widget.RelativeLayout;
import android.text.Editable;
import android.graphics.Color;
import android.widget.Toast;
import android.os.Looper;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.os.Bundle;
import android.os.Environment;
import android.view.View;
import android.view.ViewGroup;
 
import   android.webkit.WebView;
import   android.webkit.WebViewClient;
 
Activity act;
FrameLayout fl;
 
WebView webview; 
WebViewClient wbc;
 
//@Override
public void onStart() {
  super.onStart();
 
  act = this.getActivity();
 
  wbc = new WebViewClient();
 
  webview = new WebView(act);
  webview.setLayoutParams(new RelativeLayout.LayoutParams( 1200, 800 ));
  webview.setX(100);
  webview.setY(50);
  webview.setWebViewClient(wbc);
  webview.getSettings().setJavaScriptEnabled(true);
 
  webview.loadUrl("http://" + "localhost:5000/");
 
  fl = (FrameLayout)act.findViewById(0x1000);
  fl.addView(webview);
}
 
 
void settings() {
  fullScreen();
}
 
void setup() {   
  orientation(PORTRAIT);
  background(255, 250, 0);
}
 
void draw() {
}
