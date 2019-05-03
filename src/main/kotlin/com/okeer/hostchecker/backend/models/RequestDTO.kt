package com.okeer.hostchecker.backend.models

import com.fasterxml.jackson.annotation.JsonProperty

data class RequestDTO (
    @param:JsonProperty("url") val url: String,
    @param:JsonProperty("status") val status: Int
)