//
//  File.c
//  
//
//  Created by Vlad Gorlov on 04.12.20.
//

#include "Helpers.h"
#include <stddef.h>

int GetArrayLength(JNIEnv * _Nonnull env, jclass _Nonnull thisClass, jbyteArray _Nonnull bArray) {
   int len = env->GetArrayLength(bArray);
   return len;
}

jbyte* GetByteArrayElements(JNIEnv * _Nonnull env, jclass _Nonnull thisClass, jbyteArray _Nonnull bArray) {
   auto data = env->GetByteArrayElements(bArray, 0);
   return data;
}


jbyteArray data_SwiftToJava(JNIEnv * _Nonnull env, CData * _Nonnull data) {
   jbyteArray ret = env->NewByteArray(data->count);
   if (ret == NULL) {
      return NULL; //  out of memory error thrown
   }
   env->SetByteArrayRegion (ret, 0, data->count, data->data);
   return ret;
}
