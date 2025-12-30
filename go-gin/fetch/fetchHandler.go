package fetch

import (
    "net/http"
    "github.com/gin-gonic/gin"
)

type Handler struct{
    service *FetchService
}

func NewHandler(service *FetchService) *Handler {
    return &Handler{
        service: service,
    }
}

func (h *Handler) FetchPost(c *gin.Context){
    posts, err := h.service.FetchPost()
    
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{
            "error": err.Error(),
        })
        return
    }
    
    c.JSON(http.StatusOK, gin.H{  
        "data": posts,
    })
}

func (h *Handler) AggregateData(c *gin.Context){
    posts, err := h.service.AggregateData()
    
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{
            "error": err.Error(),
        })
        return
    }
    
    c.JSON(http.StatusOK, gin.H{
        "data": posts,
    })
}