package com.example.demodockersharedvol.flow

import com.example.demodockersharedvol.config.DDSVAProperties
import com.example.demodockersharedvol.service.JsonFileService
import org.springframework.integration.dsl.IntegrationFlow
import org.springframework.integration.dsl.IntegrationFlows
import org.springframework.integration.dsl.Transformers
import org.springframework.integration.file.FileReadingMessageSource.WatchEventType.CREATE
import org.springframework.integration.file.FileReadingMessageSource.WatchEventType.MODIFY
import org.springframework.integration.file.RecursiveDirectoryScanner
import org.springframework.integration.file.dsl.Files
import java.io.File

fun fileScanInputFlow(
        props: DDSVAProperties,
        service: JsonFileService
): IntegrationFlow {

    return IntegrationFlows
            .from(Files
                    .inboundAdapter(File(props.dataPath))
                    .recursive(true)
                    .scanner(RecursiveDirectoryScanner().apply {

                        val filterRegex = props.dataSets
                                .joinToString("|", ".*/(", ")/*.json")
                                .toRegex()

                        setFilter { it.filter { f -> filterRegex.matches(f.absolutePath) } }
                    })
                    .watchEvents(CREATE, MODIFY)
                    .autoCreateDirectory(true)
            ) { s -> s.poller { it.fixedDelay(1000) } }
            .transform(Transformers.objectToString())
            .log()
//                .split()
//                .filter<File> { f -> f.isFile && f.extension == "json" }
                .handle(service, "loadFile")
//                .aggregate()
            .get()
}

fun errorFlow(): IntegrationFlow {
    return IntegrationFlows
            .from("error")
            .transform(Transformers.objectToString())
            .log()
            .get()
}