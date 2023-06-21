package com.example.demodockersharedvol.config

import org.springframework.boot.context.properties.ConfigurationProperties
import java.nio.file.Path
import java.nio.file.Paths

@ConfigurationProperties("elera")
class EleraProperties(
        var cache: Cache = Cache(),
        var clear: Clear = Clear(),
        var loader: Loader = Loader(),
        var mongodb: Mongodb = Mongodb(),
        var sample: Sample = Sample(),
) {

    class Cache(
            var enabled: Boolean = true,
            var refresh: Boolean = false
    )

    class Clear(
            var db: Boolean = false,
            var transactions: Boolean = true
    )

    class Loader(
            var dataPath: Path = Paths.get("."),
            var datasets: Array<String> = emptyArray()
    )

    class Mongodb(
            var seed: Seed = Seed()
    ) {
        class Seed(
                var include: String? = null,
                var exclude: String? = null
        )
    }

    class Sample(
            var order: Boolean = true
    )
}