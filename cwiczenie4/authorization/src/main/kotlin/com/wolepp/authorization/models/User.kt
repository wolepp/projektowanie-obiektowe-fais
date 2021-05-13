package com.wolepp.authorization.models

import javax.persistence.*

@Entity
class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Int = 0

    @Column(unique = true)
    val nickname: String = ""

    @Column
    val password: String = ""
}