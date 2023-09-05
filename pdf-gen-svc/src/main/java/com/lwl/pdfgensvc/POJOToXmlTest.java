package com.lwl.pdfgensvc;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.fasterxml.jackson.dataformat.xml.ser.ToXmlGenerator;
import lombok.*;

import java.text.DecimalFormat;

public class POJOToXmlTest {
   public static void main(String args[]) throws Exception {
      try {
         DecimalFormat decimalFormat = new DecimalFormat("#.######");
         System.out.println(decimalFormat.format(123));
         System.out.println(decimalFormat.format(123.234));
         System.out.println(decimalFormat.format(1245.56788898));
         ObjectMapper xmlMapper = new XmlMapper();
         Person pojo = new Person();
         pojo.setFirstName("Raja");
         pojo.setLastName("Ramesh");
         pojo.setAddress("Hyderabad");
         pojo.setSalary(1234567687);
         pojo.setComm(0.000012);
         SimpleModule module = new SimpleModule();
         module.addSerializer(Double.class, new CustomDoubleSerializer());
         xmlMapper.registerModule(module);
         String xml = xmlMapper.writeValueAsString(pojo);
         System.out.println(xml);
      } catch(Exception e) {
         e.printStackTrace();
      }
   }
   static class CustomDoubleSerializer extends com.fasterxml.jackson.databind.JsonSerializer<Double> {
      private DecimalFormat decimalFormat = new DecimalFormat("#.################"); // Use as many '#' as needed
      @Override
      public void serialize(Double value, com.fasterxml.jackson.core.JsonGenerator gen, com.fasterxml.jackson.databind.SerializerProvider serializers) throws java.io.IOException {
         if (gen instanceof ToXmlGenerator) {
            ToXmlGenerator xmlGen = (ToXmlGenerator) gen;
            xmlGen.writeString(decimalFormat.format(value));
         } else {
            gen.writeNumber(value);
         }
      }
   }
}


@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor

class Person {
   private String firstName;
   private String lastName;
   private String address;
   @JsonSerialize(using = POJOToXmlTest.CustomDoubleSerializer.class)
   private double salary;
   @JsonSerialize(using = POJOToXmlTest.CustomDoubleSerializer.class)
   private double comm;
}