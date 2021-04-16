package controller

import (
	"dogsapp/data"
	"fmt"
	"github.com/labstack/echo/v4"
)

type Controller struct {
	e *echo.Echo
}

func NewController() *Controller {
	return &Controller{e: echo.New()}
}

func (c *Controller) Start() {
	dbconnector.GetInstance().Init()

	c.e.GET("/dog/:id", c.GetDog)
	c.e.POST("/dog", c.CreateDog)
	c.e.PUT("/dog", c.UpdateDog)
	c.e.DELETE("/dog/:id", c.DeleteDog)

	go func() {
		if err := c.e.Start(":5000"); err != nil {
			fmt.Println("Cannot start server")
		}
	}()
}

func (c *Controller) Stop() {
	if err := c.e.Close(); err != nil {
		fmt.Println("Error")
	}

	dbconnector.GetInstance().Stop()
}
