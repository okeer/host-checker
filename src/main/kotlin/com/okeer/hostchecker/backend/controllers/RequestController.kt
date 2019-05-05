package com.okeer.hostchecker.backend.controllers

import com.okeer.hostchecker.backend.services.RequestServiceBean
import javax.inject.Inject
import javax.json.Json
import javax.ws.rs.GET
import javax.ws.rs.Path
import javax.ws.rs.PathParam
import javax.ws.rs.Produces
import javax.ws.rs.core.MediaType
import javax.ws.rs.core.Response

@Path("/request")
open class RequestController {

    @Inject
    private lateinit var requestServiceBean : RequestServiceBean

    companion object {
        @JvmStatic
        fun generateErrorResponse(statusCode : Int, errorMessage : String) : Response =
                Response.status(statusCode)
                        .entity(Json.createObjectBuilder()
                                .add("error", errorMessage).build())
                        .build()
    }

    @GET
    @Path("{url : .+}")
    @Produces(MediaType.APPLICATION_JSON)
    open fun check(@PathParam("url") url : String): Response {
        if (!(url.contains(Regex("^http://.*"))))
            return generateErrorResponse(400, "$url is not http url")

        return try {
            Response.ok().entity(requestServiceBean.getProxiedResponseDTO(url)).build()
        }
        catch (e : Exception) {
            generateErrorResponse(500, "Failed to send request: ${e.message}")
        }
    }
}