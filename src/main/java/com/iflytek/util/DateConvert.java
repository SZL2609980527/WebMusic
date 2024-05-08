package com.iflytek.util;


import org.springframework.core.convert.converter.Converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateConvert implements Converter<String, Date> {
    @Override
    public Date convert(String s) {
        SimpleDateFormat sFormat=new SimpleDateFormat("yyyy-MM-dd");
        Date date=null;
        try {
            date=sFormat.parse(s);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }
}
