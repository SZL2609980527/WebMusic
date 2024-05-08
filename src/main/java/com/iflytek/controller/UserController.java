package com.iflytek.controller;

import com.alibaba.fastjson.JSON;
import com.iflytek.entity.User;
import com.iflytek.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {
    @Autowired
    private IUserService userService;

@RequestMapping(value = "/getOne",method = RequestMethod.POST)
@ResponseBody
    public String getOneUser(@RequestBody String jsonString,HttpServletRequest request) {
        User user = JSON.parseObject(jsonString, User.class);
//        System.out.println(user.getUsername()+","+user.getPassword());
        User u=userService.getOneUser(user);
        if (u != null) {
            request.getSession().setAttribute("user", u);
            if (u.getUsername().equals("admin")){
                return "admin";
            }
            return "SUCCESS";
        } else
            return "ERROR";
    }

@RequestMapping(value = "/getOneByPhone",method = RequestMethod.POST)
@ResponseBody
    public String getOneUserByPhone(String phone, String code, HttpServletRequest request) {
    System.out.println(SendSmsController.code);
    System.out.println(code);
    System.out.println(code .equals(SendSmsController.code));
        if(code .equals(SendSmsController.code)){
            User user = new User();
            user.setPhone(phone);
            User u = userService.getOneUserByPhone(user);
            if (u != null){
                request.getSession().setAttribute("user", u);
                return "SUCCESS";
            }
            else
                return "NO";
        }else
            return "ERROR";
    }

@RequestMapping(value = "/insertUser",method = RequestMethod.POST)
@ResponseBody
    public String insertOneUser(@RequestBody String jsonString){
        User user = JSON.parseObject(jsonString,User.class);
        int i=userService.insertOneUser(user);
        if (i == 1)
            return "SUCCESS";
        else
            return "ERROR";
    }

@RequestMapping(value = "/password",method = RequestMethod.POST)
@ResponseBody
    public String updateUserPassword(@RequestBody String jsonString){
        User user = JSON.parseObject(jsonString,User.class);
        int i=userService.updateUserPassword(user);
        if (i == 1)
            return "SUCCESS";
        else
            return "ERROR";
    }
@RequestMapping(value = "/updUser",method = RequestMethod.POST)
@ResponseBody
    public String updUserInformation(@RequestBody String jsonString){
        User user = JSON.parseObject(jsonString, User.class);
        System.out.println(user);
        int i = userService.updUserInformation(user);
        if (i == 1)
            return "SUCCESS";
        else
            return "ERROR";
    }
@RequestMapping(value = "/getAllUser", method = RequestMethod.GET)
@ResponseBody
    public String getAllUser(){
        List<User> list = userService.getAllUser();
        Map<String, Object> jsonObject = new HashMap<>();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count", list.size());
        jsonObject.put("data", list);
        return JSON.toJSONString(jsonObject);
    }
}
