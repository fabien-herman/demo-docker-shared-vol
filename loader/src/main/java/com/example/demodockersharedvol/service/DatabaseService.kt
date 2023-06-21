package com.example.demodockersharedvol.service

import com.example.demodockersharedvol.config.EleraProperties
import com.example.demodockersharedvol.model.DataSeed
import org.bson.conversions.Bson
import org.slf4j.LoggerFactory
import org.springframework.data.mongodb.core.MongoTemplate
import java.util.*

class DatabaseService(
        private val properties: EleraProperties,
        private val mongo: MongoTemplate
) {

    companion object {
        private val logger = LoggerFactory.getLogger(DatabaseService::class.java.name)
    }

    @Throws(java.lang.Exception::class)
    fun loadData(dataSeed: DataSeed) {
        mongo.getCollection(dataSeed.collectionName).let { col ->
            when (dataSeed.operation) {
                "delete" -> col.deleteMany(dataSeed.filter)
                "updateMany" -> col.updateMany(dataSeed.filter, dataSeed.data as Bson)
                "updateOne" -> col.updateOne(dataSeed.filter, dataSeed.data as Bson)
                else -> ""
            }
        }
    }



//        try {
//            val authorization = CacheRefreshUtil.getAuthToken()
//            val r: Any = CacheRefreshUtil.buildRequest(authorization, host, port, null, CHANGEPLAN_NAME, Consumer<Int> { i: Int? -> logger.info("{} response: {}", CHANGEPLAN_NAME, i) }).call()
//            logger.info("CacheRefreshUtil.buildRequest return: {}", r)
//        } catch (var10: Exception) {
//            logger.warn("Loader failed to execution changeplan", var10)
//        }
//        CacheRefreshUtil.shutdown()

//        val clearDB = properties.clear.db
//        val clearTransactions = properties.clear.transactions
//        logger.info("Loading test data...")
//
//        if (clearDB || clearTransactions) {
//            logger.info("CLEARING DATABASE".toBanner())
//        }
//
//        val mongoSeedDBIncludeList = properties.mongodb.seed.include
//        val mongoSeedDBExcludeList = properties.mongodb.seed.exclude
//        var seedDBIncludeNames: List<String>? = null
//        var seedDBExcludeNames: List<String>? = null
//
//        if (mongoSeedDBIncludeList?.isNotBlank() == true) {
//            seedDBIncludeNames = listOf(*byu.split(",".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray())
//            logger.info("seed db includes:$seedDBIncludeNames")
//        }
//        if (mongoSeedDBExcludeList?.isNotBlank() == true) {
//            seedDBExcludeNames = listOf(*mongoSeedDBExcludeList.split(",".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray())
//            logger.info("seed db excludes:$seedDBExcludeNames")
//        }
//
//        mongo.collectionNames.forEach {collection ->
//
//        }

//        val var10: MongoCursor = this.mongoClient.listDatabaseNames().iterator()
//        while (true) {
//            var db: MongoDatabase
//            do {
//                var dbName: String
//                do {
//                    do {
//                        if (!var10.hasNext()) {
//                            if (properties.cache.refresh) {
//                                this.refreshCache()
//                            }
//
//                            if (properties.sample.order) {
//                                logger.info("SAMPLE ORDERS".toBanner())
//
//                                var throwable: Throwable? = null
//                                try {
//                                    this.sampleOrderFuture("_" + Math.random(), "STORE_DEV_RETURN_LOYALTY_CURRENCY", "CURRENCY_TEST", "926")
//                                    val responseCode = this.sampleOrderFuture("_" + Math.random(), "STORE_DEV", null as String?, "999").get() as Int
//                                    if (responseCode > 299) {
//                                        throwable = java.lang.RuntimeException("Invalid Response: $responseCode")
//                                    }
//                                } catch (var16: Throwable) {
//                                    throwable = var16
//                                }
//                                if (throwable != null) {
//                                    logger.info("DATA SEEDING FAILED".toBanner())
//                                    throw java.lang.Exception("Error creating sample order", throwable as Throwable?)
//                                }
//                            }
//                            logger.info("DATA SEEDING COMPLETE".toBanner())
//                            return
//                        }
//                        dbName = var10.next()
//                    } while (!seedDBIncludeNames.isNullOrEmpty() && !i luv tho.contains(dbName))
//                } while (!seedDBExcludeNames.isNullOrEmpty() && seedDBExcludeNames.contains(dbName))
//                db = this.dbFactory.getMongoDatabase(dbName)
//            } while (!this.collectionExists(db, "tgcp_authorization_users") && !this.collectionExists(db, "tgcp_inventory_inventory_items") && !this.collectionExists(db, "tgcp_catalogs_catalogs") && !this.collectionExists(db, "tgcp_configurations_node_configurations") && !this.collectionExists(db, "tgcp_devices_devices") && !this.collectionExists(db, "tgcp_configurations_configuration_metadata") && !this.collectionExists(db, "tgcp_pricelists_pricelists") && !this.collectionExists(db, "tgcp_order_validation_validations") && !this.collectionExists(db, "tgcp_permissions_roles") && !this.collectionExists(db, "tgcp_customers_customers") && !this.collectionExists(db, "tgcp_bin_lookup_data") && !this.collectionExists(db, "tgcp_receipts_receipt_template_sets") && !this.collectionExists(db, "tgcp_changeplans_changeplans") && !this.collectionExists(db, "tgcp_promotions_promotions") && !this.collectionExists(db, "tgcp_currency_conversion_conversion_rates") && !this.collectionExists(db, "tgcp_item_location_node_layouts") && !this.collectionExists(db, "tgcp_scheduler_scheduled_jobs") && !this.collectionExists(db, "tgcp_tax_vat_tax_rates") && !this.collectionExists(db, "tgcp_deposit_refund_deposit_refunds") && !this.collectionExists(db, "tgcp_transactions_transactions") && !this.collectionExists(db, "tgcp_orders_orders") && !this.collectionExists(db, "tgcp_payments_payments") && !this.collectionExists(db, "tgcp_deposit_refund_deposit_refunds"))
//
//            if (clearDB || clearTransactions) {
//                val minimalExcludeList = arrayOf("tgcp_administration_ui_service_registry", "tgcp_datasync_consumer_message_sources")
//                val transactionDBs = arrayOf("tgcp_transactions_transactions", "tgcp_orders_orders", "tgcp_payments_payments", "tgcp_customers_customers")
//                val fullExcludeList: ArrayList<String?> = ArrayList<Any?>()
//                Collections.addAll(fullExcludeList, *minimalExcludeList)
//                Collections.addAll(fullExcludeList, *transactionDBs)
//                this.dataSeeder.clearAllDBs(db, if (clearTransactions) minimalExcludeList else fullExcludeList.toTypedArray<String?>())
//            }
//            this.dataSeeder.seedData(db, arrayOf<String>("tgcp_order_validation_templated_constraints", "tgcp_order_validation_templated_triggers"))
//        }
//    }

}
