package dbconnector

import (
	"dogsapp/model"
	"errors"
	"fmt"
	"strconv"
)

func (c *Dbconnector) GetDog(id string) (*model.Dog, error) {
	rows, err := c.Search(fmt.Sprintf("SELECT * FROM dogs WHERE id=%v LIMIT 1", id))
	if err != nil {
		return nil, err
	}

	defer func() {
		err = rows.Close()
		if err != nil {
			fmt.Println("error while closing")
		}
	}()

	if rows.Next() {
		dog := new(model.Dog)
		if err := rows.Scan(&dog.Id, &dog.Owner, &dog.Breed); err != nil {
			return nil, err
		}
		return dog, nil

	}
	return nil, errors.New("No dogs there")
}

func (c *Dbconnector) CreateDog(dog *model.Dog) (*model.Dog, error) {
	id, err := c.Query(fmt.Sprintf("INSERT INTO dogs (owner, breed) values ('%v', '%v')", dog.Owner, dog.Breed))
	if err != nil {
		return nil, err
	}

	dog, err = c.GetDog(strconv.FormatInt(id, 10))
	if err != nil {
		return nil, err
	}

	return dog, nil
}

func (c *Dbconnector) UpdateDog(dog *model.Dog) (*model.Dog, error) {
	oldDog, err := c.GetDog(strconv.FormatInt(dog.Id, 10))
	if err != nil {
		return nil, err
	}

	if dog.Owner == "" {
		dog.Owner = oldDog.Owner
	}

	if dog.Breed == "" {
		dog.Breed = oldDog.Breed
	}

	_, err = c.Query(fmt.Sprintf("UPDATE dogs SET owner='%v', breed='%v' WHERE id=%v", dog.Owner, dog.Breed, dog.Id))
	if err != nil {
		return nil, err
	}

	return dog, nil
}

func (c *Dbconnector) DeleteDog(dog *model.Dog) (*model.Dog, error) {
	dog, err := c.GetDog(strconv.FormatInt(dog.Id, 10))
	if err != nil {
		return nil, err
	}

	_, err = c.Query(fmt.Sprintf("DELETE FROM dogs WHERE id=%v", dog.Id))
	if err != nil {
		return nil, err
	}

	return dog, nil
}
