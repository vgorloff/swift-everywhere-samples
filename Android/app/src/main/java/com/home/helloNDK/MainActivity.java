package com.home.helloNDK;

import android.graphics.Color;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.system.ErrnoException;
import android.system.Os;
import android.view.View;
import android.widget.Button;
import android.widget.RelativeLayout;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        try {
            Os.setenv("CFFIXED_USER_HOME", this.getFilesDir().getPath(), true);
        } catch (ErrnoException e) {
            e.printStackTrace();
        }
        super.onCreate(savedInstanceState);
        final Button myButton = new Button(this);
        myButton.setText("Press me");
        myButton.setBackgroundColor(Color.YELLOW);

        RelativeLayout myLayout = new RelativeLayout(this);
        myLayout.setBackgroundColor(Color.BLUE);

        RelativeLayout.LayoutParams buttonParams =
                new RelativeLayout.LayoutParams(
                        RelativeLayout.LayoutParams.WRAP_CONTENT,
                        RelativeLayout.LayoutParams.WRAP_CONTENT);

        buttonParams.addRule(RelativeLayout.CENTER_HORIZONTAL);
        buttonParams.addRule(RelativeLayout.CENTER_VERTICAL);

        myLayout.addView(myButton, buttonParams);
        setContentView(myLayout);

        myButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                SwiftLib swiftLib = new SwiftLib();
                int value = swiftLib.sayHello();
                myButton.setText(String.valueOf(value));
            }
        });
    }


}
