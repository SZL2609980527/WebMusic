package com.iflytek.dao;

import com.iflytek.entity.MusicList;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface IMusicListDao {
    @Select("select * from musiclist where maker='admin'")
    List<MusicList> getAllMusicList();
    @Select("select * from musiclist where listId=#{id}")
    MusicList getOneList(int id);
}
