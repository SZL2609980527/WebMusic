package com.iflytek.service;

import com.iflytek.entity.EData;
import com.iflytek.entity.ListMusic;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IListMusicService {
    List<ListMusic> getOnelist(int id);
    List<ListMusic> getLikeList(String username);//查找用户的喜欢歌单
    int addLikeMusic(String username, int id);//用户添加喜欢

    int delLikeMusic(String username, int id);

    List<EData> getLikeNumber();
}


