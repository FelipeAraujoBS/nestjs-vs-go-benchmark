package server 

import (
    "go-gin/primes"
    "go-gin/fetch"
    "github.com/gin-gonic/gin"
)

func SetupRouter() *gin.Engine{
    r := gin.Default()
    
    // Handler de primes
    primesService := primes.NewService()
    primesHandler := primes.NewHandler(primesService)
    r.GET("/primes", primesHandler.GetPrimes)
    
    // Handler de fetch
    fetchService := fetch.NewFetchService()
    fetchHandler := fetch.NewHandler(fetchService)
    r.GET("/fetch", fetchHandler.FetchPost)
    r.GET("/aggregate", fetchHandler.AggregateData)
    
    return r 
}