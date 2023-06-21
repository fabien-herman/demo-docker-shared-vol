package com.example.demodockersharedvol.config

import org.springframework.boot.context.properties.EnableConfigurationProperties
import org.springframework.context.annotation.Configuration

@Configuration
@EnableConfigurationProperties(
        EleraProperties::class
)
class DDSVAConfig {

}