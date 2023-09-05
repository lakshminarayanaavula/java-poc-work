package com.lwl.emailapp;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonTypeInfo(
    use = JsonTypeInfo.Id.NAME,
    property = "type",
    visible = true)
@JsonSubTypes({
    @JsonSubTypes.Type(value = SendGrid.class, name = "SENDGRID"),
    @JsonSubTypes.Type(value = SmtpProvider.class, name = "SMTP"),
    @JsonSubTypes.Type(value = SesProvider.class, name = "SES")})
public abstract class EmailConnectionType {
     private EmailProviderType type;
}
