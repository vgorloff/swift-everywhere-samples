package com.home.helloNDK;

import android.content.Context;
import android.graphics.Color;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.system.ErrnoException;
import android.system.Os;
import android.view.View;
import android.widget.Button;
import android.widget.RelativeLayout;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        try {
            Os.setenv("CFFIXED_USER_HOME", this.getFilesDir().getPath(), true);
            // See:
            // - https://forums.swift.org/t/partial-nightlies-for-android-sdk/25909/41?u=v.gorlov
            // - https://github.com/apple/swift-corelibs-foundation/blob/84d6a68f05793f55c1a3aecf553c74fe2fae2ae9/Foundation/URLSession/libcurl/EasyHandle.swift#L187-L200
            File certificatesFile = this.getCachedAsset(this, "cacert.pem");
            Os.setenv("URLSessionCertificateAuthorityInfoFile", certificatesFile.getAbsolutePath(), true);
            // Os.setenv("URLSessionCertificateAuthorityInfoFile", "INSECURE_SSL_NO_VERIFY", true);
        } catch (Exception e) {
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


    private File getCachedAsset(Context context, String name) throws IOException {
        File cacheFile = new File(context.getCacheDir(), name);
        try {
            InputStream inputStream = context.getAssets().open(name);
            try {
                FileOutputStream outputStream = new FileOutputStream(cacheFile);
                try {
                    byte[] buf = new byte[1024];
                    int len;
                    while ((len = inputStream.read(buf)) > 0) {
                        outputStream.write(buf, 0, len);
                    }
                } finally {
                    outputStream.close();
                }
            } finally {
                inputStream.close();
            }
        } catch (IOException e) {
            throw new IOException(String.format("Could not open %s", name), e);
        }
        return cacheFile;
    }
}
