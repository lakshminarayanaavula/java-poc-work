package com.lwl.emailapp;

public enum EmailProviderType {
  SES("ses"), SENDGRID("sendgrid"),SMTP("smtp");
  private String type;
  EmailProviderType(String value) {
    this.type = value;
  }
  public String getType() {
    return type;
  }


}
