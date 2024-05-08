package com.iflytek.controller;

import com.iflytek.service.ISendsms;
import com.iflytek.util.ValidateCodeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;

@RestController
@CrossOrigin  //跨域支持
public class SendSmsController {
    @Autowired
    private ISendsms sendSms;

    public static String code = "1234";  //保存上一次的验证码用于验证

    @RequestMapping(value = "/sendSms/{phone}", method = RequestMethod.GET)
    public String sendSms(@PathVariable("phone")String phone) {
        //生成验证码
        code = ValidateCodeUtils.generateValidateCode(4).toString();
        HashMap<String, Object> param = new HashMap<>();
        param.put("code", code);

        //发送短信
        boolean isSend = sendSms.send(phone, "SMS_464455532", param);

        if (isSend){
            return "SUCCESS";
        }else {
            return "ERROR";
        }

    }

}
