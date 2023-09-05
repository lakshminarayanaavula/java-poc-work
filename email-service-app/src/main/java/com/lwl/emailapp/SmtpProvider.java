package com.lwl.emailapp;

import org.springframework.stereotype.Service;

@Service
public class SmtpProvider extends EmailConnectionType implements EmailProvider{

      @Override
      public void sendEmail(String to, String subject, String body) {
          System.out.println("Email sent using SMTP");
      }
      @Override
      public EmailProviderType getType() {
          return EmailProviderType.SMTP;
      }
}
