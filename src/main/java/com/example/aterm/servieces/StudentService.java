package com.example.aterm.servieces;

import com.example.aterm.models.Lesson;
import com.example.aterm.models.Student;
import com.example.aterm.repositories.StudentRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class StudentService {
    private final StudentRepository studentRepository;


    public List<Student> listStudents(String name) {
        if (name != null) return studentRepository.findByName(name);
        return studentRepository.findAll();
    }

    public void saveStudent(Student student) {
        log.info("Saving new {}", student);
        studentRepository.save(student);
    }

    public void deleteStudent(Long id) {
        studentRepository.deleteById(id);
    }

    public Student getStudentById(Long id) {
        return studentRepository.findById(id).orElse(null);
    }
}
