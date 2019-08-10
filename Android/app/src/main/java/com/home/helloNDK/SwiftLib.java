package com.home.helloNDK;

public class SwiftLib {

    static {
        System.loadLibrary("HelloJNICore");
    }

    public native int sayHello();
}
