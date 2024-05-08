package com.iflytek.entity;

import lombok.Data;

@Data
public class MusicList {//歌单的基本信息
    private int listId;
    private String title;
    private String description;
    private String listImg;
}
