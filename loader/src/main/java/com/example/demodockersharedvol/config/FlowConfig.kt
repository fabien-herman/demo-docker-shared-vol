package com.example.demodockersharedvol.config

import com.example.demodockersharedvol.model.DataSeed
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.data.mongodb.core.MongoTemplate
import org.springframework.expression.Expression
import org.springframework.expression.ExpressionParser
import org.springframework.integration.dsl.IntegrationFlow
import org.springframework.integration.dsl.IntegrationFlows
import org.springframework.integration.dsl.Transformers
import org.springframework.integration.dsl.integrationFlow
import org.springframework.integration.file.FileReadingMessageSource.WatchEventType.CREATE
import org.springframework.integration.file.FileReadingMessageSource.WatchEventType.MODIFY
import org.springframework.integration.file.dsl.Files
import org.springframework.integration.handler.LoggingHandler
import java.io.File

@Configuration
class FlowConfig {

    @Bean
    fun jsonFilesHandlingFlow(props: EleraProperties) = integrationFlow(
            Files
                    .inboundAdapter(props.loader.dataPath.toFile())
                    .recursive(true)
                    .filter {
                        val filterRegex = props.loader.datasets
                                .joinToString("|", ".*/(", ")/.+.json")
                                .toRegex()
                        it.filter { f -> filterRegex.matches(f.absolutePath) }
                    }
                    .useWatchService(true)
                    .watchEvents(CREATE, MODIFY),
            { poller { it.fixedDelay(200) } }
    ) {
        transform<File> { DataSeed(it) }
        route<DataSeed> {
            when (it.operation) {
                "delete" -> "delete";
                "updateOne" -> "updateOne";
                "updateMany" -> "updateMany";
                else -> "error"
            }
        }
    }

    @Bean
    fun dataSeedsDeleteHandlingFlow(template: MongoTemplate): IntegrationFlow = integrationFlow("delete") {
        log(LoggingHandler.Level.INFO, "app.Delete", "payload.filter")
    }

    @Bean
    fun dataSeedsHandlingFlow(template: MongoTemplate): IntegrationFlow = integrationFlow("updateOne") {
          log(LoggingHandler.Level.INFO, "app.updateOne", "payload")
//            .handle(
//                    MongoDb.outboundGateway(template)
//                            .collectionNameExpression("payload.collectionName")//                            .
//                            .queryExpression("payload.data")
////                        .expectSingleResult(true)
////                        .entityClass(Any::class.java)
//            )
    }

    @Bean
    fun errorHandlingFlow(): IntegrationFlow {
        return IntegrationFlows
                .from("input")
                .transform(Transformers.objectToString())
                .log()
                .get()
    }
}