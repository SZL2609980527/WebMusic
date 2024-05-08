package com.iflytek.dao;

import com.iflytek.entity.EData;
import com.iflytek.entity.ListMusic;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface IListMusicDao {
    @Select("SELECT m.musicId,m.musicName,m.img,m.album,m.singer,m.type FROM list_music AS lm, music AS m, musiclist AS l WHERE m.musicId = lm.musicId AND lm.listId = l.listId AND l.listId=#{id}")
    List<ListMusic> getOnelist(int id); //查找官方歌单中歌曲
    @Select("SELECT m.* FROM list_music AS lm, music AS m, musiclist AS l WHERE m.musicId = lm.musicId AND lm.listId = l.listId AND lm.username=#{username} AND l.listId = 5")
    List<ListMusic> getLikeList(String username);//查找用户的喜欢歌单中歌曲
    @Insert("insert into list_music(username,musicId,listId) values (#{username}, #{id}, 5)")
    int addLikeMusic(@Param("username") String username, @Param("id") int id);//用户添加喜欢
    @Delete("delete from list_music where username=#{username} and musicId=#{id}")
    int delLikeMusic(@Param("username") String username, @Param("id") int id);//用户删除喜欢
    @Select("SELECT m.musicName, count(*) as number FROM list_music AS lm, music AS m WHERE m.musicId = lm.musicId ANd lm.listId = 5  GROUP BY m.musicName")
    @Results({
            @Result(property = "name", column = "musicName"),
            @Result(property = "value", column = "number")
    })
    List<EData> getLikeNumber();
}
