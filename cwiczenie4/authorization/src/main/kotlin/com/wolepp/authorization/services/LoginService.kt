package com.wolepp.authorization.services

import com.wolepp.authorization.models.User
import com.wolepp.authorization.repositories.UserRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class LoginService @Autowired constructor(val userRepository: UserRepository) {

    fun register(user: User): User {
        return userRepository.save(user)
    }

    fun login(nickname: String, password: String): User? {
        return userRepository.findByNicknameAndPassword(nickname, password)
    }

    fun logout(nickname: String): User? {
        return userRepository.findByNickname(nickname)
    }
}