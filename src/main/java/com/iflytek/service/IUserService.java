package com.iflytek.service;

import com.iflytek.entity.User;

import java.util.List;

public interface IUserService {
    User getOneUser(User user);
    User getOneUserByPhone(User user);
    int insertOneUser(User user);
    int updateUserPassword(User user);
    int updUserInformation(User user);
    List<User> getAllUser();
}
