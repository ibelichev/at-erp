package com.example.aterm.servieces;


import com.example.aterm.models.Prepod;
import com.example.aterm.repositories.PrepodRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class PrepodService {
    private final PrepodRepository prepodRepository;

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
}
