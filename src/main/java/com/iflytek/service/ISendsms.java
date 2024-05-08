package com.iflytek.service;

import java.util.Map;

public interface ISendsms {

    //手机号、模板代码、验证码
    boolean send(String phoneNum, String templateCode, Map<String, Object> code);

}
