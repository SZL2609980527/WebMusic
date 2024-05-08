package com.iflytek.entity;

import lombok.Data;

import java.util.Date;
@Data
public class User {//用户
    String username;
    String password;
    String question;
    String answer;
    Date birthday;
    String phone;
    String nickname;
}
