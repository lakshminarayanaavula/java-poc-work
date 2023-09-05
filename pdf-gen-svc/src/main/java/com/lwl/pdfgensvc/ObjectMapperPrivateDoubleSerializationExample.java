package com.lwl.pdfgensvc;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.module.SimpleModule;

import java.io.IOException;
import java.text.DecimalFormat;

public class ObjectMapperPrivateDoubleSerializationExample {
    public static void main(String[] args) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        SimpleModule module = new SimpleModule();
        module.addSerializer(Double.class, new CustomDoubleSerializer());
        objectMapper.registerModule(module);

        MyClass myClass = new MyClass();
        myClass.setPrivateValue(0.0000123456789);

        String json = objectMapper.writeValueAsString(myClass);
        System.out.println(json);
    }

    static class CustomDoubleSerializer extends JsonSerializer<Double> {
        private DecimalFormat decimalFormat = new DecimalFormat("#.################"); // Use as many '#' as needed

        @Override
        public void serialize(Double value, JsonGenerator gen, SerializerProvider serializers) throws IOException {
            gen.writeString(decimalFormat.format(value));
        }
    }

    static class MyClass {
        @JsonSerialize(using = CustomDoubleSerializer.class)
        private double privateValue;

        public double getPrivateValue() {
            return privateValue;
        }

        public void setPrivateValue(double privateValue) {
            this.privateValue = privateValue;
        }
    }
}