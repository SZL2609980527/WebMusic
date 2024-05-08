package com.iflytek.dao;

import com.iflytek.entity.Music;
import org.apache.ibatis.annotations.*;

import java.util.List;
@Mapper
public interface IMusicDao {
    @Select("select * from music ")
    List<Music> getAllMusic();
    @Select("select * from music  LIMIT #{id}, 15")
    List<Music> getRecommend(int id);
    @Select("select * from music where musicId=#{id}")
    Music getOneMusic(int id);
    @Select("select * from music where musicName LIKE '%' #{musicName} '%'")
    List<Music> getMusicByName(String musicName);
    @Select("select * from music where type=#{type}")
    List<Music> getMusicByType(String type);
    @Insert("insert into music(musicName,album,singer,url,img,type) values (#{musicName}, #{album}, #{singer}, #{url}, #{img}, #{type})")
    int addMusic(Music music);
    @Update("update music set musicName=#{musicName},album=#{album},singer=#{singer},url=#{url},img=#{img},type=#{type} where musicId=#{musicId}")
    int updateMusic(Music music);
    @Delete("delete from music where musicId=#{id}")
    int delOneMusic(int id);
}
