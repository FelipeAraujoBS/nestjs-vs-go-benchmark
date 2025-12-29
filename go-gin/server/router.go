package server 

import (
	"go-gin/primes"

	"github.com/gin-gonic/gin"
)

func SetupRouter() *gin.Engine{
	r := gin.Default()

	handler := primes.NewHandler()
	r.GET("/primes", handler.GetPrimes)

	return r 
}