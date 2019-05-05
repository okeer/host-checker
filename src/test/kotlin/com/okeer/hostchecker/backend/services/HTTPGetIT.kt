package com.okeer.hostchecker.backend.services

import org.jboss.arquillian.container.test.api.Deployment
import org.jboss.arquillian.container.test.api.RunAsClient
import org.jboss.arquillian.junit.Arquillian
import org.jboss.shrinkwrap.api.ShrinkWrap
import org.jboss.shrinkwrap.api.asset.EmptyAsset
import org.jboss.shrinkwrap.api.spec.JavaArchive
import org.jboss.shrinkwrap.api.spec.WebArchive
import org.jboss.shrinkwrap.resolver.api.maven.Maven
import org.jboss.shrinkwrap.resolver.api.maven.archive.importer.MavenImporter
import org.junit.Test
import org.junit.runner.RunWith
import javax.ws.rs.client.ClientBuilder
import javax.ws.rs.core.MediaType
import kotlin.test.assertEquals

@RunWith(Arquillian::class)
class HTTPGetIT {
    @Test
    @RunAsClient
    fun givenWarIsDeployed_whenGETtoValidUrlExecuted_ShouldReturn200() = ClientBuilder.newClient().let {
        assertEquals(200,
                it
                        .target("http://127.0.0.1:8080/checker/api/request/http://google.com")
                        .request(MediaType.APPLICATION_JSON_TYPE)
                        .get()
                        .status,
                "Should return 200 on valid URL"
        )
    }

    companion object {
        @JvmStatic
        @Deployment(name = "checker.war", order = 1, testable = false)
        fun createAppDeploy() : WebArchive {
            return ShrinkWrap.create(MavenImporter::class.java).loadPomFromFile("pom.xml").importBuildOutput()
                    .`as`(WebArchive::class.java)
        }

        @JvmStatic
        @Deployment(name = "test.war", order = 2)
        fun createTestDeploy(): WebArchive {
            val kotlinRuntime = Maven.configureResolver()
                    .workOffline()
                    .withMavenCentralRepo(true)
                    .withClassPathResolution(true)
                    .loadPomFromFile("pom.xml")
                    .resolve("org.jetbrains.kotlin:kotlin-stdlib")
                    .withTransitivity().`as`(JavaArchive::class.java)

            var kotlinTest = Maven.configureResolver()
                    .workOffline()
                    .withMavenCentralRepo(true)
                    .withClassPathResolution(true)
                    .loadPomFromFile("pom.xml")
                    .resolve("org.jetbrains.kotlin:kotlin-test")
                    .withTransitivity().`as`(JavaArchive::class.java)

            return ShrinkWrap.create(WebArchive::class.java, "test.war")
                    .addAsManifestResource(EmptyAsset.INSTANCE, "beans.xml")
                    .addAsLibraries(kotlinRuntime)
                    .addAsLibraries(kotlinTest)
        }
    }
}