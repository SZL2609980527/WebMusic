package com.iflytek.dao;

import com.iflytek.entity.EData;
import com.iflytek.entity.RecentMusic;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface IRecentMusicDao {
    @Select("SELECT m.*, r.number FROM recent as r, music as m where r.musicId = m.musicId and r.username = #{username} ")
    List<RecentMusic> getRecentMusic(String username);
    @Insert("insert into  recent (username, musicId, number) values (#{username}, #{musicId}, 1) ON DUPLICATE KEY UPDATE number = number + 1")
    int addRecentMusic(@Param("username") String username, @Param("musicId") int musicId);
    @Select("SELECT m.* FROM recent as r, music as m where r.musicId = m.musicId GROUP BY m.musicId ORDER BY number DESC ,m.musicId ASC LIMIT 20")
    List<RecentMusic> getTopMusic();
    @Select("SELECT r.number, m.musicName FROM recent as r, music as m where r.musicId = m.musicId GROUP BY m.musicId ORDER BY number DESC ,m.musicId ASC LIMIT 10")
    @Results({
            @Result(property = "name", column = "musicName"),
            @Result(property = "value", column = "number")
    })
    List<EData> getRecEData();
}
