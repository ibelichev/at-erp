package com.example.aterm.servieces;

import com.example.aterm.models.Agreement;
import com.example.aterm.models.Student;
import com.example.aterm.models.Subscription;
import com.example.aterm.repositories.AgreementRepository;
import com.example.aterm.repositories.StudentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.springframework.http.ResponseEntity;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AgreementSerivce {

    private final AgreementRepository agreementRepository;
    private final StudentRepository studentRepository;


    public ResponseEntity<byte[]> downloadAgreement(Subscription subscription) throws IOException {

        LocalDate date;
        Agreement agreement = agreementRepository.findBySubscriptionId(subscription.getId());


        if (agreement != null) {
            // договор существует
            date = agreement.getDate();
        } else {
            // договор не существует
            date = LocalDate.now();
            agreement = new Agreement(date, subscription, true);
            agreementRepository.save(agreement);
            agreement = agreementRepository.findBySubscriptionId(subscription.getId());
        }


        Student student = studentRepository.getById(subscription.getStudent().getId());

        InputStream templateInputStream = new FileInputStream("src/main/resources/templates/template.docx");
        XWPFDocument document = new XWPFDocument(templateInputStream);

        replacePlaceholder(document, "{{dogovor_number}}", Long.toString(agreement.getId()));
        replacePlaceholder(document, "{{dogovor_date}}", date.toString());
        replacePlaceholder(document, "{{client_fio}}", student.getName());
        replacePlaceholder(document, "{{passport_seria}}", student.getPassportSeries());
        replacePlaceholder(document, "{{passport_number}}", student.getPassportNumber());
        replacePlaceholder(document, "{{birthday}}", student.getBirthday());

        // Запись дока в массив байтов
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        document.write(outputStream);
        document.close();

        String filename = String.format("Договор %s.docx", student.getName()).replace(" ", "_");
        String encodedFilename = java.net.URLEncoder.encode(filename, StandardCharsets.UTF_8);

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename*=UTF-8''" + encodedFilename)
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .body(outputStream.toByteArray());
    }


    private void replacePlaceholder(XWPFDocument document, String placeholder, String replacement) {
        for (XWPFParagraph paragraph : document.getParagraphs()) {
            replaceInParagraph(paragraph, placeholder, replacement);
        }

        document.getTables().forEach(table -> {
            table.getRows().forEach(row -> {
                row.getTableCells().forEach(cell -> {
                    cell.getParagraphs().forEach(paragraph -> {
                        replaceInParagraph(paragraph, placeholder, replacement);
                    });
                });
            });
        });
    }

    private void replaceInParagraph(XWPFParagraph paragraph, String placeholder, String replacement) {
        List<XWPFRun> runs = paragraph.getRuns();
        if (runs != null && !runs.isEmpty()) {
            StringBuilder fullText = new StringBuilder();
            for (XWPFRun run : runs) {
                String text = run.getText(0);
                if (text != null) {
                    fullText.append(text);
                }
            }
            String updatedText = fullText.toString().replace(placeholder, replacement);
            int runsSize = runs.size();

            for (int i = runsSize - 1; i >= 0; i--) {
                paragraph.removeRun(i);
            }

            XWPFRun newRun = paragraph.createRun();
            newRun.setText(updatedText);
        }
    }




}