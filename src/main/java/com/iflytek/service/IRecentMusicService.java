package com.iflytek.service;

import com.iflytek.entity.EData;
import com.iflytek.entity.RecentMusic;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IRecentMusicService {
    List<RecentMusic> getRecentMusic(String username);
    int addRecentMusic(String username, int musicId);

    List<RecentMusic> getTopMusic();

    List<EData> getRecEData();

}
