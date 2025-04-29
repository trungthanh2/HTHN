pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
    }
}
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    
    // START: FlutterFire Configuration
    id("com.google.gms.google-services") version "4.3.15" apply false
    // END: FlutterFire Configuration

}
rootProject.name = "flutter_application_1"
include(":app")
