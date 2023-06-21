package com.example.demodockersharedvol.service

import com.example.demodockersharedvol.model.DataSeed
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper

class DataSeedService(
        val dbService: DatabaseService
) {

    private val om = jacksonObjectMapper()

    private var cacheOn = true;

    fun cacheEnabled(status: Boolean){
        this.cacheOn = status
    }

    fun loadFile(dataSeed: DataSeed) {
        println(om.writeValueAsString(dataSeed))
        dbService.loadData(dataSeed)
    }
}