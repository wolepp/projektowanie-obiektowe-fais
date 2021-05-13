package com.wolepp.authorization.repositories

import com.wolepp.authorization.models.User
import org.springframework.data.repository.CrudRepository
import org.springframework.lang.Nullable

interface UserRepository : CrudRepository<User, Int> {
    @Nullable
    fun findByNicknameAndPassword(nickname: String, password: String): User

    @Nullable
    fun findByNickname(nickname: String): User
}