package com.example.aterm.servieces;

import com.example.aterm.models.Subscription;
import com.example.aterm.repositories.SubscriptionReposiory;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class SubscriptionService {
    private final SubscriptionReposiory subscriptionReposiory;

    public List<Subscription> listSubscriptions(String subscriptionName) {
        if (subscriptionName != null) return subscriptionReposiory.findBySubscriptionName(subscriptionName);
        return subscriptionReposiory.findAll();
    }
    public void saveSubscription(Subscription subscription) {
        log.info("Saving new {}", subscription);
        subscriptionReposiory.save(subscription);
    }

    public void deleteSubscription(Long id) {
        subscriptionReposiory.deleteById(id);
    }

    public Subscription getSubscriptionById(Long id) {
        try {
            return (Subscription) subscriptionReposiory.findAllById(Collections.singleton(id));
        } catch (Exception e) {
            System.out.println("ошибка в student service");
            return null;
        }

    }

    public List<Subscription> getSubscriptionByUserId(Long id) {
//        try {
//            return subscriptionReposiory.findById(id).orElse(null);
//        } catch (Exception e) {
//            return null;
//        }

        return subscriptionReposiory.findByStudentId(id);
    }

    public void reduceBalance(Long id) {
        Subscription curSubscription = subscriptionReposiory.findById(id).orElse(null);
        int red = curSubscription.getToPay() / curSubscription.getAmountOfLessons();
        curSubscription.setMoney(curSubscription.getMoney() - red);
        subscriptionReposiory.save(curSubscription);
    }

    public void nowLessonUp(Long id) {
        Subscription curSubscription = subscriptionReposiory.findById(id).orElse(null);
        curSubscription.setNowLesson(curSubscription.getNowLesson() + 1);
        subscriptionReposiory.save(curSubscription);
    }


}
