package primes 

import (
	"net/http"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
)

type Handler struct{}

func NewHandler() *Handler {
	return &Handler{}
}

func (h *Handler) GetPrimes(c *gin.Context){
	nStr := c.DefaultQuery("n", "100000")
	n, _ := strconv.Atoi(nStr)

	start := time.Now()
	result := Calculate(n)
	elapsed := time.Since(start)

	c.JSON(http.StatusOK, gin.H{
		"count": len(result),
		"elapsedMs": elapsed.Milliseconds(),
	})
}