package model

type Dog struct {
	Id    int64  `json:"id"`
	Owner string `json:"owner"`
	Breed string `json:"breed"`
}
