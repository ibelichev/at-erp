package com.example.aterm.servieces;


import com.example.aterm.models.Lesson;
import com.example.aterm.models.Prepod;
import com.example.aterm.repositories.LessonRepository;
import com.example.aterm.repositories.PrepodRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class PrepodService {
    private final PrepodRepository prepodRepository;
    private final LessonRepository lessonRepository;
    private final LessonService lessonService;

    public List<Prepod> listPrepod(String name) {
        if (name != null) return prepodRepository.findByName(name);
        return prepodRepository.findAll();
    }

    public void savePrepod(Prepod prepod) {
        log.info("Saving new {}", prepod);
        prepodRepository.save(prepod);
    }

    public void deletePrepod(int id) {
        prepodRepository.deleteById(id);
    }

    public boolean isPrepodFree(String prepod, String date, String time) {
        List<Lesson> lessons = lessonRepository.findLessonsByPrepod(prepod);

        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate requestDate = LocalDate.parse(date, dateFormatter);

        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
        LocalTime requestTime = LocalTime.parse(time, timeFormatter);

        for (Lesson lesson : lessons) {
            LocalDate lessonDate = LocalDate.parse(lesson.getDate(), dateFormatter);
            if (lessonDate.equals(requestDate)) {
                LocalTime lessonStartTime = LocalTime.parse(lesson.getTime(), timeFormatter);
                int lessonDurationMinutes = 60; // Предполагаем, что урок длится 60 минут.
                LocalTime lessonEndTime = lessonStartTime.plusMinutes(lessonDurationMinutes);

                if (!requestTime.isBefore(lessonStartTime) && requestTime.isBefore(lessonEndTime)) {
                    return false; // Время занято.
                }
            }
        }
        return true; // Время свободно.
    }

}