package com.lwl.emailapp;

import org.springframework.stereotype.Service;

@Service
public class SesProvider extends EmailConnectionType implements EmailProvider{

        @Override
        public void sendEmail(String to, String subject, String body) {
            System.out.println("Email sent using SES");
        }
        @Override
        public EmailProviderType getType() {
            return EmailProviderType.SES;
        }
}
