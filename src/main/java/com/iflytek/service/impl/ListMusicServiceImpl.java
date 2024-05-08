package com.iflytek.service.impl;

import com.iflytek.dao.IListMusicDao;
import com.iflytek.entity.EData;
import com.iflytek.entity.ListMusic;
import com.iflytek.service.IListMusicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ListMusicServiceImpl implements IListMusicService {
    @Autowired
    private IListMusicDao listMusicDao;

    @Override
    public List<ListMusic> getOnelist(int id) {
        return listMusicDao.getOnelist(id);
    }

    @Override
    public List<ListMusic> getLikeList(String username) {
        return listMusicDao.getLikeList(username);
    }

    @Override
    public int addLikeMusic(String username, int id) {
        return listMusicDao.addLikeMusic(username, id);
    }

    @Override
    public int delLikeMusic(String username, int id) {
        return listMusicDao.delLikeMusic(username, id);
    }

    @Override
    public List<EData> getLikeNumber() {
        return listMusicDao.getLikeNumber();
    }
}
