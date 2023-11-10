// lib/*.dart files working as expected in Emulator (Nexus 6)
// lib/*.dart files working as expected in Physical Device (One Plus 7)

// The following issue persists:
// The supplied phased action failed with an exception.
// Could not create task ':generateLockfiles'.
// Process 'command 'android/gradlew.bat'' finished with non-zero exit value 1

// Looks like an issue with Dependencies:
// - Flutter
// - Android Studio (SDK)
// - Java
// - Gradle
// - Kotlin
// - Groovy

// Tried downgrading JDK from 21 to 17.
// Tried downgrading Flutter from 3.13 to 3.10
// Tried updating the values of gradle builds & wrapper
// Tried ./gradlew clean & build - some other issue after success
// Compatibility Matrix

// Will get back later - if not already resolved in the future versions of Flutter.