package com.lwl.emailapp;

import org.springframework.stereotype.Service;

@Service
public interface EmailProvider {
    void sendEmail(String to, String subject, String body);
    EmailProviderType getType();
}
