package com.example.demodockersharedvol;

import org.springframework.boot.Banner
import org.springframework.boot.SpringApplication;
import org.springframework.boot.WebApplicationType
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;

@SpringBootApplication
open class DemoDockerSharedVolApplication


//@JvmStatic
fun main(args: Array<String>) {
    SpringApplicationBuilder()
            .sources(DemoDockerSharedVolApplication::class.java)
            .web(WebApplicationType.NONE)
            .bannerMode(Banner.Mode.OFF)
            .run(*args)
}