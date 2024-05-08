package com.iflytek.service.impl;

import com.iflytek.dao.IMusicListDao;
import com.iflytek.entity.MusicList;
import com.iflytek.service.IMusicListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class MusicListServiceImpl implements IMusicListService {
    @Autowired
    private IMusicListDao musicListDao;
    @Override
    public List<MusicList> getAllMusicList() {
        return musicListDao.getAllMusicList();
    }

    @Override
    public MusicList getOneList(int id) {
        return musicListDao.getOneList(id);
    }

}
