//
//  File.h
//  
//
//  Created by Vlad Gorlov on 04.12.20.
//

#ifndef File_h
#define File_h

#include "/usr/local/ndk/21.3.6528147/sysroot/usr/include/jni.h"

typedef struct {
    const signed char * _Nonnull data;
   unsigned int count;
} CData;

#ifdef __cplusplus
extern "C" {
#endif

int GetArrayLength(JNIEnv * _Nonnull env, jclass thisClass, jbyteArray bArray);
jbyte* _Nonnull GetByteArrayElements(JNIEnv * _Nonnull env, jclass _Nonnull thisClass, jbyteArray _Nonnull bArray);

jbyteArray _Nullable data_SwiftToJava(JNIEnv * _Nonnull env, CData * _Nonnull data);

#ifdef __cplusplus
}
#endif

#endif /* File_h */
