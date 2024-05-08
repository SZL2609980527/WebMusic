package com.iflytek.controller;

import com.alibaba.fastjson.JSON;
import com.iflytek.entity.EData;
import com.iflytek.entity.RecentMusic;
import com.iflytek.service.IRecentMusicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class RecentMusicController {
    @Autowired
    private IRecentMusicService recentMusicService;

@RequestMapping(value = "/getRecent", method = RequestMethod.GET)
@ResponseBody
    public String getRecentMusic(String username) {
        List<RecentMusic> list = recentMusicService.getRecentMusic(username);
        Map<String, Object> jsonObject = new HashMap<>();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count", list.size());
        jsonObject.put("data", list);
        return JSON.toJSONString(jsonObject);
    }
@RequestMapping(value = "addRecentMusic", method = RequestMethod.GET)
@ResponseBody
    public String addRecentMusic(String username,int musicId){
       int i = recentMusicService.addRecentMusic(username,musicId);
       if(i !=0)
           return "SUCCESS";
       else
           return "ERROR";
    }
@RequestMapping(value = "/getTopMusic", method = RequestMethod.GET)
@ResponseBody
    public String getTopMusic(){
        List<RecentMusic> list = recentMusicService.getTopMusic();
        Map<String, Object> jsonObject = new HashMap<>();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count", list.size());
        jsonObject.put("data", list);
        return JSON.toJSONString(jsonObject);
    }

@RequestMapping(value = "/getRecEData", method = RequestMethod.GET)
@ResponseBody
    public String getRecEData(){
        List<EData> list = recentMusicService.getRecEData();
        return JSON.toJSONString(list);
    }
}
