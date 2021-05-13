package com.wolepp.authorization.controllers

import com.wolepp.authorization.models.User
import com.wolepp.authorization.models.UserNotFound
import com.wolepp.authorization.services.LoginService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/authorize")
class LoginController @Autowired constructor(val loginService: LoginService) {

    @PostMapping("/register")
    fun register(@RequestBody user: User): User {
        return loginService.register(user)
    }

    @GetMapping("/login")
    fun login(@RequestParam("nickname") nickname: String, @RequestParam("password") password: String): User {
        return loginService.login(nickname, password) ?: throw UserNotFound()
    }

    @GetMapping("/logout")
    fun logout(@RequestParam("nickname") nickname: String): User {
        return loginService.logout(nickname) ?: throw UserNotFound()
    }
}