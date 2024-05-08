package com.iflytek.entity;

import lombok.Data;

@Data
public class ListMusic {//查看歌单中具体的歌曲
    private int musicId;
    private int listId;
    private String musicName;
    private String album;
    private String singer;
    private String url;
    private String img;
    private String type;
    private String title;
    private String description;
    private String listImg;
}
