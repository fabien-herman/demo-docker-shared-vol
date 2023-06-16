package com.example.demodockersharedvol.config

import com.example.demodockersharedvol.flow.errorFlow
import com.example.demodockersharedvol.flow.fileScanInputFlow
import com.example.demodockersharedvol.service.JsonFileService
import org.springframework.boot.context.properties.EnableConfigurationProperties
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
@EnableConfigurationProperties(DDSVAProperties::class)
class DDSVAConfig {

    @Bean
    fun jsonFileService() = JsonFileService()

    @Bean
    fun fileScanInputHandling(
            properties: DDSVAProperties,
            service: JsonFileService
    ) = fileScanInputFlow(properties, service)

    @Bean
    fun errorHandling() = errorFlow()
}