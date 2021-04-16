package controller

import (
	"dogsapp/data"
	"dogsapp/model"
	"github.com/labstack/echo/v4"
	"net/http"
	"strconv"
)

func (c *Controller) GetDog(ctx echo.Context) error {
	conn := dbconnector.GetInstance()

	dog, err := conn.GetDog(ctx.Param("id"))
	if err != nil {
		return echo.NewHTTPError(http.StatusNotFound, err.Error())
	}

	return ctx.JSON(http.StatusOK, dog)
}

func (c *Controller) CreateDog(ctx echo.Context) error {
	conn := dbconnector.GetInstance()
	dog := new(model.Dog)

	if err := ctx.Bind(dog); err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	created, err := conn.CreateDog(dog)
	if err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	return ctx.JSON(http.StatusOK, created)
}

func (c *Controller) UpdateDog(ctx echo.Context) error {
	conn := dbconnector.GetInstance()
	dog := new(model.Dog)

	if err := ctx.Bind(dog); err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	created, err := conn.UpdateDog(dog)
	if err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	return ctx.JSON(http.StatusOK, created)

}

func (c *Controller) DeleteDog(ctx echo.Context) error {
	conn := dbconnector.GetInstance()
	id, err := strconv.ParseInt(ctx.Param("id"), 10, 64)

	dog := &model.Dog{
		Id: id,
	}

	if err := ctx.Bind(dog); err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	deleted, err := conn.DeleteDog(dog)
	if err != nil {
		return echo.NewHTTPError(http.StatusNotFound, err.Error())
	}

	return ctx.JSON(http.StatusOK, deleted)

}
