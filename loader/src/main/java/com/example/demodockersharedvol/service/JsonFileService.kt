package com.example.demodockersharedvol.service

import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import java.io.File

class JsonFileService {

    private val om = jacksonObjectMapper()

    fun loadFile(jsonFile: Any) {
        println(om.writeValueAsString(jsonFile))
    }
}