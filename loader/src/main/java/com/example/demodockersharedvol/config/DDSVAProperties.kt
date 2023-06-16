package com.example.demodockersharedvol.config

import org.springframework.boot.context.properties.ConfigurationProperties
import java.io.File

@ConfigurationProperties("loader")
class DDSVAProperties {
    var dataPath: String = "./"
    var dataSets: Array<String> = arrayOf()
}