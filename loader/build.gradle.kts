import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    id("org.springframework.boot")
    id("io.spring.dependency-management")
    kotlin("jvm")
    kotlin("plugin.spring")
}

group = "com.example"
version = "0.0.1-SNAPSHOT"

java {
    sourceCompatibility = JavaVersion.VERSION_11
}

repositories {
    mavenCentral()
    maven {
        url = uri("http://tgcsnexus2.rtptgcs.com:28081/repository/tgcs-maven-group/")
        isAllowInsecureProtocol = true
    }
}

dependencies {
    implementation ("org.springframework.boot:spring-boot-starter-integration")
    implementation ("org.springframework.boot:spring-boot-starter-data-mongodb")
    implementation("org.springframework.boot:spring-boot-configuration-processor")

    implementation ("org.springframework.integration:spring-integration-file")
    implementation ("org.springframework.integration:spring-integration-mongodb")
    implementation ("org.mongodb:mongodb-driver-sync")

    implementation ("com.tgcs.tgcp:tgcp-framework-sample-data-seeder:2.1.3-2023.5.9-6829-f40386f15") {
        exclude(group = "*", module = "*")
    }

    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
    implementation("org.jetbrains.kotlin:kotlin-reflect")
}

tasks.withType<KotlinCompile> {
    kotlinOptions {
        freeCompilerArgs += "-Xjsr305=strict"
        jvmTarget = "11"
    }
}