package com.example.demodockersharedvol.model

import org.bson.BsonArray
import org.bson.BsonDocument
import org.bson.conversions.Bson
import java.io.File

class DataSeed(
        val collectionName: String,
        private val document: BsonArray
)  {
    constructor(file: File) : this(file.nameWithoutExtension, BsonArray.parse(file.readText()))

    val header: BsonDocument = document[0].asDocument()

    val description: String = header.getString("description").value
    val operation: String = header.getString("operation").value
    val filter: BsonDocument = header.getDocument("filter")

    val data: BsonArray = document.also { it.removeFirstOrNull() }
}