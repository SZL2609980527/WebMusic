package com.iflytek.controller;

import com.alibaba.fastjson.JSON;
import com.iflytek.entity.MusicList;
import com.iflytek.service.IMusicListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MusicListController {
    @Autowired
    private IMusicListService musicListService;

@RequestMapping(value = "/getMusicList", method = RequestMethod.GET)
@ResponseBody
    public String getAllMusicList(){
        List<MusicList> list = musicListService.getAllMusicList();
        return JSON.toJSONString(list);
    }

@RequestMapping(value = "/getOneList", method = RequestMethod.GET)
@ResponseBody
    public String getOneList(int id){
        MusicList musicList = musicListService.getOneList(id);
        return JSON.toJSONString(musicList);
    }

}
