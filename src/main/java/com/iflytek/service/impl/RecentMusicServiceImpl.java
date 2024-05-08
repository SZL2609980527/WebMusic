package com.iflytek.service.impl;

import com.iflytek.dao.IRecentMusicDao;
import com.iflytek.entity.EData;
import com.iflytek.entity.RecentMusic;
import com.iflytek.service.IRecentMusicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class RecentMusicServiceImpl implements IRecentMusicService {
    @Autowired
    private IRecentMusicDao recentMusicDao;

    @Override
    public List<RecentMusic> getRecentMusic(String username) {
        return recentMusicDao.getRecentMusic(username);
    }

    @Override
    public int addRecentMusic(String username, int musicId) {
        return recentMusicDao.addRecentMusic(username,musicId);
    }

    @Override
    public List<RecentMusic> getTopMusic() {
        return recentMusicDao.getTopMusic();
    }

    @Override
    public List<EData> getRecEData() {
        return recentMusicDao.getRecEData();
    }


}
