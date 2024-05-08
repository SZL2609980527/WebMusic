package com.iflytek.service;

import com.iflytek.entity.MusicList;

import java.util.List;

public interface IMusicListService {
    List<MusicList> getAllMusicList();
    MusicList getOneList(int id);

}
