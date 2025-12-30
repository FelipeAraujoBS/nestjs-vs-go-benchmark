package primes

import (
    "net/http"
    "strconv"
    "time"
    "github.com/gin-gonic/gin"
)

type Handler struct{
    service *Service
}

func NewHandler(service *Service) *Handler {
    return &Handler{
        service: service,
    }
}

func (h *Handler) GetPrimes(c *gin.Context){
    nStr := c.DefaultQuery("n", "100000")
    n, err := strconv.Atoi(nStr)
    if err != nil {
        c.JSON(http.StatusBadRequest, gin.H{
            "error": "Invalid parameter n",  
        })
        return  
    }
    
    start := time.Now()
    result := h.service.Calculate(n) 
    elapsed := time.Since(start)
    
    c.JSON(http.StatusOK, gin.H{
        "count": len(result),
        "elapsedMs": elapsed.Milliseconds(),
    })
}