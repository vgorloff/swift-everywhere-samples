#include "/usr/local/ndk/21.4.7075529/sysroot/usr/include/android/log.h"

static inline int __android_log_print_1(const char *str) {
    return __android_log_print(ANDROID_LOG_INFO, "SwiftAndroid", "%s", str);
}
