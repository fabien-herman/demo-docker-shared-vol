package com.example.demodockersharedvol.util

import com.example.demodockersharedvol.model.DataSeed
import org.bson.BsonDocument
import java.io.File
import kotlin.math.floor
import kotlin.math.ceil


fun String?.toBanner(width: Int = 40, char: Char = '*'): String {
    val line = "".padStart(width, char)
    return (this ?: "-")
            .let(String::trim)
            .let(String::uppercase)
            .let { txt ->
                val len = ceil(txt.length / 2.0).toInt()
                val offset = floor((width - len) / 2.0).toInt()
                txt.padStart(offset + len, ' ').padEnd(width - 2, ' ').let { "$char$it$char" }
            }
            .let { "$line\n$it\n$line\n" }
}