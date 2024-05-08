package com.iflytek.entity;

import lombok.Data;

@Data
public class RecentMusic {//最近播放
    private String username;
    private int musicId;
    private String musicName;
    private String album;
    private String singer;
    private String url;
    private String img;
    private String type;
    private String number;
}
