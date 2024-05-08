package com.iflytek.controller;

import com.alibaba.fastjson.JSON;
import com.iflytek.entity.Music;
import com.iflytek.service.IMusicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

@Controller
public class MusicController {
    @Autowired
    private IMusicService musicService;

@RequestMapping(value = "/getMusic",method = RequestMethod.GET)
@ResponseBody
    public String getAllMusic(){
        List<Music> musics= musicService.getAllMusic();
        Map<String, Object> jsonObject = new HashMap<>();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count", musics.size());
        jsonObject.put("data", musics);
        return JSON.toJSONString(jsonObject);
    }
@RequestMapping(value = "/getRecommend",method = RequestMethod.GET)
@ResponseBody
    public String getRecommend(){ //猜你喜欢  随机数
        Random r=new Random();
        int id=r.nextInt(21);

        List<Music> musics= musicService.getRecommend(id);
        Map<String, Object> jsonObject = new HashMap<>();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count", musics.size());
        jsonObject.put("data", musics);
        return JSON.toJSONString(jsonObject);
    }

@RequestMapping(value = "/getOneMusic", method = RequestMethod.GET)
@ResponseBody
    public String getOneMusic(int id){
        Music music= musicService.getOneMusic(id);
        return music.getUrl();
    }
@RequestMapping(value = "/getMusicByName",method = RequestMethod.GET)
@ResponseBody
    public String getMusicByName(String musicName){
        List<Music> list = musicService.getMusicByName(musicName);
        Map<String, Object> jsonObject = new HashMap<>();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count", list.size());
        jsonObject.put("data", list);
        return JSON.toJSONString(jsonObject);
    }

@RequestMapping(value = "/getMusicByType",method = RequestMethod.GET)
@ResponseBody
    public String getMusicByType(String type){
        List<Music> list = musicService.getMusicByType(type);
        Map<String, Object> jsonObject = new HashMap<>();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count", list.size());
        jsonObject.put("data", list);
        return JSON.toJSONString(jsonObject);
    }
@RequestMapping(value = "/updateMusic", method = RequestMethod.POST)
@ResponseBody
    public String updateMusic(@RequestBody String jsonString){
        Music music = JSON.parseObject(jsonString, Music.class);
        System.out.println(music);
        int i = musicService.updateMusic(music);
        if (i == 1)
            return "SUCCESS";
        else
            return "ERROR";
    }
@RequestMapping(value = "/addMusic", method = RequestMethod.POST)
@ResponseBody
    public String addMusic(@RequestBody String jsonString){
        Music music = JSON.parseObject(jsonString, Music.class);
        System.out.println(music);
        int i = musicService.addMusic(music);
        if (i == 1)
            return "SUCCESS";
        else
            return "ERROR";
    }
@RequestMapping(value = "/delOneMusic", method = RequestMethod.GET)
    public String delOneMusic(int id){
        int i = musicService.delOneMusic(id);
        if (i == 1)
            return "redirect:/jsp/MusicManage.jsp";
        else
            return "redirect:/jsp/MusicManage.jsp";
    }
}
