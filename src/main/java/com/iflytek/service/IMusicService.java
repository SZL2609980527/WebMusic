package com.iflytek.service;

import com.iflytek.entity.Music;

import java.util.List;

public interface IMusicService {
    List<Music> getAllMusic();
    List<Music> getRecommend(int id);
    Music getOneMusic(int id);
    List<Music> getMusicByName(String musicName);
    List<Music> getMusicByType(String type);
    int addMusic(Music music);
    int updateMusic(Music music);
    int delOneMusic(int id);
}
