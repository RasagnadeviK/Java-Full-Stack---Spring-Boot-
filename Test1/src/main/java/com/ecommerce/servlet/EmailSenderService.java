package com.ecommerce.servlet;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailSenderService {
    private final String username = "nirvaana90066@gmail.com"; // Your email
    private final String password = "tswnppunvelqgfjg"; // Your password

    public void sendEmail(String to, String subject, String body) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com"); // Update with your SMTP server
        props.put("mail.smtp.port", "587"); // Update with your SMTP port

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(username));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setText(body);

        Transport.send(message);
    }
}
