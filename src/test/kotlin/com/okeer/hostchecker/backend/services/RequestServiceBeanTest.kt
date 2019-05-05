package com.okeer.hostchecker.backend.services

import com.okeer.hostchecker.backend.models.RequestDTO
import org.jboss.arquillian.container.test.api.Deployment
import org.jboss.arquillian.junit.Arquillian
import org.jboss.shrinkwrap.api.ShrinkWrap
import org.jboss.shrinkwrap.api.asset.EmptyAsset
import org.jboss.shrinkwrap.api.spec.JavaArchive
import org.jboss.shrinkwrap.api.spec.WebArchive
import org.jboss.shrinkwrap.resolver.api.maven.Maven
import org.junit.Assert.assertNotNull
import org.junit.Test
import org.junit.runner.RunWith
import javax.inject.Inject

@RunWith(Arquillian::class)
class RequestServiceBeanTest {

    @Inject
    internal lateinit var serviceBean : RequestServiceBean

    @Test
    fun whenContainerStarted_EJBShouldBeInjected() {
        assertNotNull(serviceBean)
    }

    companion object {
        @JvmStatic
        @Deployment
        fun createDeployment(): WebArchive {
            val kotlinRuntime = Maven.configureResolver()
                    .workOffline()
                    .withMavenCentralRepo(true)
                    .withClassPathResolution(true)
                    .loadPomFromFile("pom.xml")
                    .resolve("org.jetbrains.kotlin:kotlin-stdlib")
                    .withTransitivity().`as`(JavaArchive::class.java)

            return ShrinkWrap.create(WebArchive::class.java, "test.war")
                    .addPackage(RequestDTO::class.java.`package`)
                    .addPackage(RequestServiceBean::class.java.`package`)
                    .addAsManifestResource(EmptyAsset.INSTANCE, "beans.xml")
                    .addAsLibraries(kotlinRuntime)
        }
    }
}
