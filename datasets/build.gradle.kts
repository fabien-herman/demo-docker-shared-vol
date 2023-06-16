plugins {
    id("com.bmuschko.docker-remote-api") version "9.3.1"
}

import com.bmuschko.gradle.docker.tasks.image.*

group = "com.example"
version = "0.0.1-SNAPSHOT"

tasks.create("buildMyAppImage", DockerBuildImage::class) {
//    inputDir.set(files("Dockerfile"))
    images.add("test/demo-datasets:${version}")
}
