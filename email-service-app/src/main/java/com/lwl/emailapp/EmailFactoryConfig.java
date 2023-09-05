package com.lwl.emailapp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class EmailFactoryConfig {
  private Map<EmailProviderType,EmailProvider> map = new HashMap<>();

  @Autowired
  public EmailFactoryConfig(List<EmailProvider> providers){
    for(EmailProvider provider:providers){
      map.put(provider.getType(), provider);
      System.out.println(map);
    }
  }
  public EmailProvider getProvider(EmailProviderType type){
    return map.get(type);
  }
}
