package main

import "go-gin/server"

func main(){
    r := server.SetupRouter()
    r.Run(":8080")
}