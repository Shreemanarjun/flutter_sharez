# Flutter Proguard Rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class com.google.android.gms.internal.** { *; }
-keep class com.google.android.gms.common.internal.safeparcel.SafeParcelable { *; }
-keep class com.google.android.gms.common.api.internal.IStatusCallback { *; }
-keep class com.google.android.gms.common.api.internal.IStatusCallback$Stub { *; }
-keep class com.google.android.gms.common.api.internal.IStatusCallback$Stub$Proxy { *; }

# Google Play Core rules to fix R8 missing class errors
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.splitcompat.SplitCompatApplication { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }
-keep class com.google.android.play.core.** { *; }

# Keep Hive classes
-keep class com.hivedb.** { *; }
-keep class net.hivedb.** { *; }

# Keep rhttp classes
-keep class com.rhttp.** { *; }
