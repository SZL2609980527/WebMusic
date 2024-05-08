package com.iflytek.service.impl;

import com.iflytek.dao.IUserDao;
import com.iflytek.entity.User;
import com.iflytek.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements IUserService {
    @Autowired
    private IUserDao userDao;
    @Override
    public User getOneUser(User user) {
        return userDao.getOneUser(user);
    }

    @Override
    public User getOneUserByPhone(User user) {
        return userDao.getOneUserByPhone(user);
    }

    @Override
    public int insertOneUser(User user) {
        return userDao.insertOneUser(user);
    }

    @Override
    public int updateUserPassword(User user) {
        return userDao.updateUserPassword(user);
    }

    @Override
    public int updUserInformation(User user) {
        return userDao.updUserInformation(user);
    }

    @Override
    public List<User> getAllUser() {
        return userDao.getAllUser();
    }
}
