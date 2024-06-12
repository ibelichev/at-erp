package com.example.aterm.configurations;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@NoArgsConstructor
@Data
public class LessonsConfig {
    private int startTime = 9;
    private int finishTime = 22;
}