package com.example.aterm.servieces;

import com.example.aterm.models.Lesson;
import com.example.aterm.models.Subscription;
import com.example.aterm.repositories.LessonRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class LessonService {
    private final LessonRepository lessonRepository;

    public List<Lesson> findAll() {
        return lessonRepository.findAll();
    }

    public Lesson findLessonById(int id) {
        return lessonRepository.findById(id).orElse(null);
    }

    public Map<String, List<Lesson>> groupLessonsByPrepod(List<Lesson> lessons) {
        Map<String, List<Lesson>> lessonsByPrepod = new LinkedHashMap<>();
        Collections.sort(lessons, Comparator.comparing(Lesson::getTime));
        for (Lesson lesson : lessons) {
            String prepod = lesson.getPrepod();
            if (!lessonsByPrepod.containsKey(prepod)) {
                lessonsByPrepod.put(prepod, new ArrayList<>());
            }
            lessonsByPrepod.get(prepod).add(lesson);
        }

        return lessonsByPrepod;
    }

    public void updateStatus(int lessonId, String status) {
        Lesson lessonToUpdate = lessonRepository.findById(lessonId).orElse(null);
        lessonToUpdate.setStatus(status);
        lessonRepository.save(lessonToUpdate);
    }


    public void saveLesson(Lesson lesson) {
        log.info("Saving new {}", lesson);
        lessonRepository.save(lesson);
    }

    public void deleteLesson(int id) {
        lessonRepository.deleteById(id);
    }


    // создать двумерный массив с временем по интервалам, передавать в первый окно, во второй ключ свободен/занят. проверять через lessonRepository.FindByDateAndTime.orElse(null); if null: свободно

}
