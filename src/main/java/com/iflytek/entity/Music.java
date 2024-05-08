package com.iflytek.entity;

import lombok.Data;

@Data
public class Music {//歌曲
    int musicId;
    String musicName;
    String album;
    String singer;
    String url;
    String img;
    String type;
}
