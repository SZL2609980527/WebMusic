package com.iflytek.controller;

import com.alibaba.fastjson.JSON;
import com.iflytek.entity.EData;
import com.iflytek.entity.ListMusic;
import com.iflytek.service.IListMusicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ListMusicController {
    @Autowired
    private IListMusicService listMusicService;

@RequestMapping(value = "/getlist", method = RequestMethod.GET)
@ResponseBody
    public String getOneList(int id){
        List<ListMusic> list = listMusicService.getOnelist(id);
        Map<String, Object> jsonObject = new HashMap<>();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count", list.size());
        jsonObject.put("data", list);
        return JSON.toJSONString(jsonObject);
    }

@RequestMapping(value = "/getLikeList", method = RequestMethod.GET)
@ResponseBody
    public String getLikeList(String username){
        List<ListMusic> list = listMusicService.getLikeList(username);
        Map<String, Object> jsonObject = new HashMap<>();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count", list.size());
        jsonObject.put("data", list);
        return JSON.toJSONString(jsonObject);
    }

@RequestMapping(value = "/addLikeMusic", method = RequestMethod.POST)
@ResponseBody
    public String addLikeMusic(@RequestParam("username") String username, @RequestParam("musicId") int musicId){
       int i = 0;
       try{
           i = listMusicService.addLikeMusic(username, musicId);
       }catch (Exception e){
           System.out.println("有错误！");
       }
       if(i != 0)
           return "SUCCESS";
       else
           return "ERROR";
    }

    @RequestMapping(value = "/delLikeMusic", method = RequestMethod.POST)
    @ResponseBody
    public String delLikeMusic(@RequestParam("username") String username, @RequestParam("musicId") int musicId){
        int i = 0;
        try{
            i = listMusicService.delLikeMusic(username, musicId);
        }catch (Exception e){
            System.out.println("有错误！");
        }
        if(i != 0)
            return "SUCCESS";
        else
            return "ERROR";
    }

    @RequestMapping(value = "/getLikeNumber", method = RequestMethod.GET)
    @ResponseBody
    public String getLikeNumber(){
        List<EData> list = listMusicService.getLikeNumber();
        return JSON.toJSONString(list);
    }
}
