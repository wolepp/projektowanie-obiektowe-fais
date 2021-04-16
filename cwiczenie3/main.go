package main

import (
	"dogsapp/controller"
	"fmt"
	"os"
)

func main() {
	stop := make(chan os.Signal, 1)
	controller := controller.NewController()
	controller.Start()
	fmt.Println("Started")

	{
		<-stop
		controller.Stop()
		fmt.Println("Closed")
	}
}
