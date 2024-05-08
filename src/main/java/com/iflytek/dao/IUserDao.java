package com.iflytek.dao;

import com.iflytek.entity.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface IUserDao {
    @Select("select * from user where username = #{username} and password = #{password}")
    User getOneUser(User user);
    @Select("select * from user where phone = #{phone}")
    User getOneUserByPhone(User user);
    @Insert("INSERT INTO user (username, password, question, answer, phone) VALUES (#{username},#{password},#{question},#{answer},#{phone}) ")
    int insertOneUser(User user);
    @Update("update user set password = #{password} where username = #{username} and question=#{question} and answer=#{answer}")
    int updateUserPassword(User user);
    @Update("update user set nickname = #{nickname}, phone = #{phone}, birthday = #{birthday} where username = #{username}")
    int updUserInformation(User user);
    @Select("SELECT * FROM user WHERE username != 'admin'")
    List<User> getAllUser();
}
