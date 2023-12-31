package com.example.aterm.controllers;

import com.example.aterm.models.Lesson;
import com.example.aterm.models.Prepod;
import com.example.aterm.models.Student;
import com.example.aterm.models.Subscription;
import com.example.aterm.repositories.LessonRepository;
import com.example.aterm.repositories.StudentRepository;
import com.example.aterm.repositories.SubscriptionReposiory;
import com.example.aterm.servieces.LessonService;
import com.example.aterm.servieces.PrepodService;
import com.example.aterm.servieces.StudentService;
import com.example.aterm.servieces.SubscriptionService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

@Controller
@RequiredArgsConstructor
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
public class AdminController {

    private final StudentService studentService;
    private final SubscriptionService subscriptionService;

    private final LessonService lessonService;
    private final PrepodService prepodService;
    private final StudentRepository studentRepository;
    private final SubscriptionReposiory subscriptionReposiory;
    private final LessonRepository lessonRepository;
    @GetMapping("/students")
    public String students(@RequestParam(name = "name", required = false) String name, Model model) {
        model.addAttribute("students", studentService.listStudents(name));
        return "students";
    }

    @GetMapping("/student/{id}")
    public String studentInfo(@PathVariable Long id, Model model, @RequestParam(name = "subscriptionName", required = false) String name, @RequestParam(name = "name", required = false) String prepodName) {
        Student student = studentRepository.getById(id);
        model.addAttribute("student", student);
        List<Subscription> subscriptions = student.getSubscriptions();
        if (!subscriptions.isEmpty()) {
            try {
                List<Lesson> lessons = new ArrayList<>();
                for (Subscription subscription : subscriptions) {
                    lessons.addAll(lessonRepository.findBySubscription(subscription));
                }

                List<Prepod> prepods = prepodService.listPrepod(prepodName);

                model.addAttribute("subscriptions", subscriptions);
                model.addAttribute("lessons", lessons);
                model.addAttribute("prepods", prepods);
//                System.out.println(subscriptions.toString());
            } catch (Exception e) {
                System.out.println("ошибка в controller");
            }
            return "student-info-subs-new";
        }

        return "student-info";
    }



    @GetMapping("/subscriptions")
    public String subscriptions(@RequestParam(name = "subscriptionName", required = false) String name, Model model) {
        model.addAttribute("subscriptions", subscriptionService.listSubscriptions(name));
        return "subscriptions";
    }

    @GetMapping("/prepods")
    public String prepods(@RequestParam(name = "name", required = false) String name, Model model) {
        model.addAttribute("prepods", prepodService.listPrepod(name));
        return "prepods";
    }

    @PostMapping("/prepod/create")
    public String createPrepod(@ModelAttribute Prepod prepod) {
        prepodService.savePrepod(prepod);
        return "redirect:/prepods";
    }


    @PostMapping("/prepod/{id}/delete")
    public String deletePrepod(@PathVariable("id") int id) {
        prepodService.deletePrepod(id);
        return "redirect:/prepods";
    }


    @PostMapping("/student/create")
    public String studentCreate(@ModelAttribute Student student) {
        System.out.println(student.toString());
        studentService.saveStudent(student);
        return "redirect:/students";
    }

    @PostMapping("/subscriptions/add")
    public String subscriptionCreate(@ModelAttribute Subscription subscription, @RequestParam Long studentId) {
        Student student = studentService.getStudentById(studentId);
        subscription.setStudent(student);
        subscriptionService.saveSubscription(subscription);
        return "redirect:/students";
    }

    @PostMapping("/student/delete/{id}")
    public String deleteStudent(@PathVariable Long id) {
        studentService.deleteStudent(id);
        return "redirect:/students";
    }

    @PostMapping("/subscription/delete/{id}")
    public String deleteSubscription(@PathVariable Long id, HttpServletRequest request) {
        subscriptionService.deleteSubscription(id);
        String url = request.getRequestURI();
        return "redirect:/students";
    }

    @PostMapping("/lesson/{id}/delete")
    public String deleteLesson(@PathVariable int id) {
        lessonService.deleteLesson(id);
        return "redirect:/students";
    }

    @PostMapping("/lesson/{id}/update/{subscriptionId}/{status}")
    public String updateLesson(@PathVariable int id, @PathVariable long subscriptionId, @PathVariable String status) {
        lessonService.updateStatus(id, status);
        subscriptionService.reduceBalance((long) subscriptionId);
        subscriptionService.nowLessonUp((long) subscriptionId);
        return String.format("redirect:/subscription/%s", subscriptionId);
    }

    @GetMapping("/lessons")
    public String getAllLessons(Model model) {
        List<Lesson> lessons = lessonService.findAll();
        Map<String, List<Lesson>> lessonsByPrepod = lessonService.groupLessonsByPrepod(lessons);
        model.addAttribute("lessonsByPrepod", lessonsByPrepod);
        return "lessons";
    }

    @GetMapping("/subscription/{id}")
    public String subscription(@PathVariable Long id, Model model, @RequestParam(name = "subscriptionName", required = false) String name, @RequestParam(name = "name", required = false) String prepodName){
        Subscription sub = subscriptionReposiory.getById(id);
        model.addAttribute("subscription", sub);
        model.addAttribute("student", sub.getStudent());
        model.addAttribute("prepods", prepodService.listPrepod(prepodName));
        model.addAttribute("lessons", lessonRepository.findLessonsBySubscriptionId(id));
        return "subscription";
    }
}
