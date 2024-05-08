package com.iflytek.service.impl;

import com.iflytek.dao.IMusicDao;
import com.iflytek.entity.Music;
import com.iflytek.service.IMusicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service()
public class MusicServiceImpl implements IMusicService {
    @Autowired
    private IMusicDao musicDao;
    @Override
    public List<Music> getAllMusic() {
        return musicDao.getAllMusic();
    }

    @Override
    public List<Music> getRecommend(int id) {
        return musicDao.getRecommend(id);
    }

    @Override
    public Music getOneMusic(int id) {
        return musicDao.getOneMusic(id);
    }

    @Override
    public List<Music> getMusicByName(String musicName) {
        return musicDao.getMusicByName(musicName);
    }

    @Override
    public List<Music> getMusicByType(String type) {
        return musicDao.getMusicByType(type);
    }

    @Override
    public int addMusic(Music music) {
        return musicDao.addMusic(music);
    }

    @Override
    public int updateMusic(Music music) {
        return musicDao.updateMusic(music);
    }

    @Override
    public int delOneMusic(int id) {
        return musicDao.delOneMusic(id);
    }


}
