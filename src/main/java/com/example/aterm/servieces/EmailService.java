package com.example.aterm.servieces;

import freemarker.template.Configuration;
import freemarker.template.TemplateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.util.Map;

@Component
public class EmailService {
    @Autowired
    private JavaMailSender emailSender;

    @Autowired
    private Configuration freemarkerConfig;

    @Value("${spring.mail.username}")
    private String sendFrom;

    public void sendSimpleMessage(String to, String subject, String text) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(sendFrom);
        message.setTo(to);
        message.setSubject(subject);
        message.setText(text);
        emailSender.send(message);
    }

    public void sendHtmlMessage(String to, String subject, String templateName, Map<String, Object> model) {
        MimeMessage message = emailSender.createMimeMessage();

        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(to);
            helper.setFrom(sendFrom);
            helper.setSubject(subject);

            String htmlBody = FreeMarkerTemplateUtils.processTemplateIntoString(
                    freemarkerConfig.getTemplate(templateName), model);
            helper.setText(htmlBody, true);
        } catch (MessagingException | IOException | TemplateException e) {
            e.printStackTrace();
        }

        emailSender.send(message);
    }
}