package com.okeer.hostchecker.backend.controllers

import java.util.*
import javax.ws.rs.ApplicationPath
import javax.ws.rs.core.Application

@ApplicationPath("api")
class RestApplication : Application() {
    private val classes = HashSet<Class<*>>(Arrays.asList<Class<RequestController>>(RequestController::class.java))
    override fun getClasses() = classes
}