package com.example.aterm.models;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class LessonFrame {
    private String date;
    private String time;
    private String prepod;
    private boolean isAviable;
}