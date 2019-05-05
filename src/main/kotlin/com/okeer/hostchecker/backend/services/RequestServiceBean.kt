package com.okeer.hostchecker.backend.services

import com.okeer.hostchecker.backend.models.RequestDTO
import javax.ejb.Stateless
import javax.ws.rs.client.ClientBuilder

@Stateless
open class RequestServiceBean {
    fun getProxiedResponseDTO(url : String) : RequestDTO = ClientBuilder.newClient()
            .let { RequestDTO(url, it.target(url).request().get().status) }
}