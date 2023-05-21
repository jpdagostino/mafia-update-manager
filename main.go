package main

import (
	"net/http"
	"os"
	"os/exec"
	"log"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)


func setupRouter(configToken string, onAuth string) *gin.Engine {
	r := gin.Default()

	r.GET("/update/:token", func(c *gin.Context) {
		token := c.Param("token")
		if(token == configToken) {
			exec.Command(onAuth).Run()
			c.JSON(http.StatusOK, gin.H{"status": "ok"})
		}
	})

	return r
}

func main() {
	err := godotenv.Load()

	if err != nil {
	  log.Fatal("Error loading .env file")
	}

	r := setupRouter(os.Getenv("TOKEN"), os.Getenv("ON_AUTH"))
	r.Run(":8080")
}
